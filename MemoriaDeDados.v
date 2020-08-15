/*Memória de Dados do Processador*/

module MemoriaDeDados (Endereco, DadoEscrita, clock, FlagEscrita, DadoLeitura);
	//Dados para escrita
	input [31:0] DadoEscrita;
	//Endereço da memória
	input [31:0] Endereco;
	//Sinal do clock
	input clock;
	//Flag para indicar escrita na memória de dados
	input FlagEscrita;
	//Saida sobre o que está na memória
	output reg [31:0] DadoLeitura;
	//Memória para salvar até 20 dados
	reg [31:0] Memoria [19:0];
	
	//Sempre na borda de subida do clock
	always @ (negedge clock) 
	begin		
		//Se eu quiser escrever algo na memória:
		if(FlagEscrita == 1) Memoria[Endereco] = DadoEscrita;
		//O dado de saida é acessado no endereço solicitado
		DadoLeitura <= Memoria[Endereco];
	end
endmodule
