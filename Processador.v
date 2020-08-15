/*Código Principal do Processador*/

module Processador (Reset, unidade, dezena, centena, milhar, uniPC, dezPC,
entradaFPGA, clkFPGA, clock, SaidaPC, saidaULA, uniFPGA, dezFPGA, checkBanco,
DadoLidoMemoria, zeroflag, DadoLeitura1, DadoLeitura2);

	//Controle do clock
	input clkFPGA;
	//Controle do reset
	input Reset;
	//Entrada do FPGA
	input [4:0] entradaFPGA;
	
	//Variáveis com tamanho de 32 bits
	wire [31:0] Instrucao, Dado, EntradaPC, check, SaidaExtendida, 
	saidaMUX1, saidaMUX2, entrada;
	//Variáveis com tamanho de 9 bits				
	wire [8:0] RegLeitura1, RegLeitura2, RegEscrita;
	//Variáveis com tamanho de 4 bits
	wire [3:0] controleULA;	
	//Variáveis com tamanho de 2 bits
	wire [1:0] controleDesvios, controleEnderecamento, FlagMuxULA;
	//Variáveis com tamanho de 1 bit
	wire BreakFlag, NopFlag, FlagEscritaReg, FlagJumpReg, controleSinal,
	FlagEscritaMemoria, controleMuxMD, controleMuxBR, printFlag, FlagLoad,
	FlagULA, flagsaida;
	
	//Clock
	output reg clock;
	//Saída visual no display de 7 segmentos
	output [6:0] unidade, dezena, centena, milhar, uniPC, dezPC, uniFPGA, dezFPGA;
	//Saidas auxiliares
	output [31:0] SaidaPC, saidaULA, checkBanco, DadoLidoMemoria, DadoLeitura1, DadoLeitura2;
	
	output zeroflag;

	/*Temporizador do clock*/
	reg [26:0] contador;
	always @ (posedge clkFPGA) // Sempre na subida do clock, os procedimentos
	begin 						   // a seguir acontecerão
		
		if ((contador == 26'd25000000) | (Reset)) //se a contagem foi atingida
		//if ((contador == 26'd1) | (Reset))    //para a simulação
		begin 								            // ou o reset acionado
			contador <= 26'd0;                     // o contador é zerado
			clock <= 1;                            // e a uma subida no clock temporizado acontece
		end
		else                                      // se não
		begin 
			contador = contador + 1;               // o contador é incrementado
			clock <= 0;                            // e a saida permanece em baixo
		end
		
	end
	
	//Ok
	ProgramCounter PC (
		.clock(clock), 
		.BreakFlag(BreakFlag), 
		.NopFlag(NopFlag),
		.Reset(Reset), 
		.EntradaPC(EntradaPC), 
		.SaidaPC(SaidaPC),
	);
	
	//OK
	MemoriaDeInstrucao MI (
		.Endereco(SaidaPC), 
		.Instrucao(Instrucao),
		.clock(clock)
	);

	//
	UnidadeDeControle UC (
		.opcode(Instrucao[31:27]), 
		.controleULA(controleULA), 
		.FlagMuxULA(FlagMuxULA), 
		.FlagEscritaMemoria(FlagEscritaMemoria), 
		.controleMuxMD(controleMuxMD), 
		.controleMuxBR(controleMuxBR), 
		.FlagEscritaReg(FlagEscritaReg), 
		.controleEnderecamento(controleEnderecamento), 
		.controleSinal(controleSinal), 
		.controleDesvios(controleDesvios), 
		.BreakFlag(BreakFlag), 
		.FlagJumpReg(FlagJumpReg), 
		.NopFlag(NopFlag), 
		.PrintFlag(printFlag),
		.FlagLoad(FlagLoad),
		.FlagULA(FlagULA),
		.flagsaida(flagsaida)
	);
	
	//Ok
	ModosDeEnderecamento ME (
		.controle(controleEnderecamento), 
		.instrucao(Instrucao[26:0]), 
		.RA(RegLeitura1), 
		.RB(RegLeitura2), 
		.RC(RegEscrita)
	);
	
	//Ok
	BancoDeRegistradores BR (
		.Dado(RegLeitura2), 
		.RegLeitura1(RegLeitura1), 
		.RegLeitura2(RegLeitura2), 
		.RegEscrita(RegEscrita), 
		.FlagEscrita(FlagEscritaReg), 
		.EnderecoPC(SaidaPC), 
		.clock(clock), 
		.FlagJump(FlagJumpReg),        //jalFlag
		.DadoLeitura1(DadoLeitura1), 
		.DadoLeitura2(DadoLeitura2), 
		.Saida(checkBanco),
		.FlagLoad(FlagLoad),
		.EscritaULA(Dado),
		.FlagULA(FlagULA),
		.Memoria(DadoLidoMemoria)
	);
	
	//Ok
	ExtensorDeBits EB (
		.controle(controleSinal),
		.tamanho14(Instrucao[31:18]), 
		.tamanho23(Instrucao[31:9]), 
		.saida(SaidaExtendida)
	);
	
	//Ok
	MultiplexadorULA muxULA (
		.flag(FlagMuxULA), 
		.entrada1(RegLeitura2), 
		.entrada2(SaidaExtendida), 
		.entrada3(DadoLeitura2),
		.entrada4(checkBanco),
		.saida(saidaMUX1)
	);
	
	//Ok
	UnidadeLogicaAritmetica ULA (
		.comando(controleULA), 
		.entrada1(DadoLeitura1), 
		.entrada2(saidaMUX1), 
		.saida(saidaULA), 
		.zeroflag(zeroflag)
	);
	
	//Ok - Controle do PC
	ControleDeDesvios CD (
		.comando(controleDesvios), 
		.clock(clock), 
		.ZeroFlag(zeroflag), 
		.imediato(RegEscrita), 
		.ProgramCounter(SaidaPC), 
		.saida(EntradaPC), 
		.saidaULA(saidaULA),
		.Reset(Reset)
	);	  
	
	//Ok
	MemoriaDeDados MD (
		.Endereco(saidaULA), 
		.DadoEscrita(checkBanco), 
		.clock(clock), 
		.FlagEscrita(FlagEscritaMemoria), 
		.DadoLeitura(DadoLidoMemoria)
	);
	
	//Ok
	MultiplexadorMD muxMD (
		.flag(controleMuxMD),
		.entrada1(DadoLidoMemoria), 
		.entrada2(saidaULA), 
		.saida(saidaMUX2)  
	);
	
	//Ok
	MultiplexadorBR muxBR (
		.flag(controleMuxBR),
		.entrada1(saidaMUX2), 
		.entrada2(entrada), 
		.saida(Dado)
	);
		
	//Ok
	EntradaSaida ES (
		.entrada(saidaULA),
		.saida(entrada), 
		.unidade(unidade), 
		.dezena(dezena), 
		.centena(centena), 
		.milhar(milhar), 
		.uniPC(uniPC), 
		.dezPC(dezPC), 
		.uniFPGA(uniFPGA),
		.dezFPGA(dezFPGA),
		.saidaPC(SaidaPC), 
		.flag(printFlag),
		.entradaFPGA({27'h0000, entradaFPGA}),
		.flagsaida(flagsaida)
	); 
	
endmodule
