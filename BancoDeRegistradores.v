/*Banco de Registradores do Processador*/

module BancoDeRegistradores (Dado, RegLeitura1, RegLeitura2, RegEscrita, 
	FlagEscrita, EnderecoPC, clock, FlagJump, DadoLeitura1, DadoLeitura2, Saida,
	FlagLoad, EscritaULA, FlagULA, Memoria);
	//Dado de 32 bits para a escrita
	input [31:0] Dado, EscritaULA, Memoria;
	//Registradores de 9 bits indicar onde será a leitura
	input [8:0] RegLeitura1, RegLeitura2;
	//Registrador de 9 bits para indicar onde será a escrita
	input [8:0] RegEscrita;
	//Registrador de 9 bits para o endereço do PC
	input [31:0] EnderecoPC;
	//Flag para sinalizar quando haverá escrita
	input FlagEscrita, FlagLoad, FlagULA;
	//Variável para controle do pulso do clock
	input clock;
	//Flag para sinalizar o endereço de volta da função jump 
	input FlagJump;
	//Dados para leitura no banco
	output [31:0] DadoLeitura1, DadoLeitura2;
	//Saida para confirmar escrita
	output [31:0] Saida;
	//Banco de 32 Registradores de 32 bits cada
	reg [31:0] Banco [31:0];
	
	always @ (posedge clock) 
	begin			
		//Load reg to reg
		if(FlagLoad == 1) Banco[RegEscrita] = Memoria;
		//Se for executar uma função de Jump And Link, salvar o endereço do PC
		if(FlagJump == 1) Banco[RegEscrita] = EnderecoPC;
		//Se for gravar algum dado no banco de registradores, gravar dado
		if(FlagEscrita == 1) Banco[RegEscrita] = Dado;		
		//ULA
		if(FlagULA == 1) Banco[RegEscrita] = EscritaULA; 
		
	end

	//a saida para confirmar escrita recebe o dado gravado
	assign Saida = Banco[RegEscrita];
	//os dados que foram solicitados leitura são salvos nas variáveis output
	assign DadoLeitura1 = Banco[RegLeitura1];
	assign DadoLeitura2 = Banco[RegLeitura2];
	
endmodule
