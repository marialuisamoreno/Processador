/*Unidade de Entrada e Saída do Processador*/

module EntradaSaida (entrada, saida, unidade, dezena, centena, milhar, 
uniPC, dezPC, uniFPGA, dezFPGA, saidaPC, flag, entradaFPGA, flagsaida);
	
	//Variáveis de entrada
	input [31:0] entrada, saidaPC, entradaFPGA;
	//Comando de escrita
	input flag, flagsaida;
	//Variáveis auxiliares para a conversão
	wire [3:0] bcdUnidade, bcdDezena, bcdCentena, bcdUnidadeMilhar, bcdDezenaMilhar, 
	bcdPCUnidade, bcdPCDezena, bcdPCcent, bcdPCmil, bcdPCmilhao, bcdUniFPGA, bcdDezFPGA,
	bcdCentFPGA, bcdMilFPGA, bcdMilhaoFPGA;
	//Saída convertida para o display de 7 segmentos
	output [6:0] unidade, dezena, centena, milhar, uniPC, dezPC, uniFPGA, dezFPGA;
	//Variável de saída			
	output reg [31:0] saida;
	
	Conversor Binary2BCD1 (.binario(entrada), .ones(bcdUnidade), .tens(bcdDezena), .hundreds(bcdCentena),
	.thousands(bcdUnidadeMilhar), .millions(bcdDezenaMilhar), .flag(flagsaida));
	
	Conversor Binary2BCD2 (.binario(saidaPC), .ones(bcdPCUnidade), .tens(bcdPCDezena), .hundreds(bcdPCcent),
	.thousands(bcdPCmil), .millions(bcdPCmilhao), .flag(1));
	
	Conversor Binary2BCD3 (.binario(entradaFPGA), .ones(bcdUniFPGA), .tens(bcdDezFPGA), .hundreds(bcdCentFPGA),
	.thousands(bcdMilFPGA), .millions(bcdMilhaoFPGA), .flag(1));
				
	Display7Segmentos A (.entrada(bcdUnidade), .display(unidade));
	Display7Segmentos B (.entrada(bcdDezena), .display(dezena));
	Display7Segmentos C (.entrada(bcdCentena), .display(centena));
	Display7Segmentos D (.entrada(bcdUnidadeMilhar), .display(milhar));
	
	Display7Segmentos F (.entrada(bcdPCUnidade), .display(uniPC));
	Display7Segmentos G (.entrada(bcdPCDezena), .display(dezPC));
	
	Display7Segmentos H (.entrada(bcdUniFPGA), .display(uniFPGA));
	Display7Segmentos I (.entrada(bcdDezFPGA), .display(dezFPGA));
	
	always @ (*) 
	begin
		saida = 0;
		
		if(flag == 1) saida <= entradaFPGA;
	end
	
endmodule
