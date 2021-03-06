/*Unidade Lógica e Aritmética do Processador*/

module UnidadeLogicaAritmetica (comando, entrada1, entrada2, saida, zeroflag);
	//as entradas 1 e 2 são do tamanho de 32 bits
	input [31:0] entrada1, entrada2;
	//o comando possui um tamanho de 4 bits
	input [3:0] comando;
	
	//a saida será do tamanho do dado da entrada, 32 bits
	output reg [31:0] saida;
	//zero flag, flag auxiliar
	output reg zeroflag;
	
	always @ (comando or entrada1 or entrada2) 
	begin
		saida = 0;
		zeroflag = 0;
		
		case(comando[3:0])
			//operação aritmética de SOMA
			4'b0000: saida = entrada1 + entrada2;
			
			//operação aritmética de SUBTRAÇÃO
			4'b0001: saida = entrada1 - entrada2;
			
			//operação aritmética de MULTIPLICAÇÃO
			4'b0010: saida = entrada1 * entrada2;
			
			//operação aritmética de DIVISÃO
			4'b0011: saida = entrada1 / entrada2;
			
			//operação aritmética de RESTO DA DIVISÃO
			4'b0100: saida = entrada1 % entrada2;
			
			//operação lógica E
			4'b0101: saida = entrada1 & entrada2;
			
			//operação lógica OU
			4'b0110: saida = entrada1 | entrada2;
			
			//operação lógica NÃO
			4'b0111: saida = ~entrada1;
			
			//operação lógica OU EXCLUSIVO
			4'b1000: saida = entrada1 ^ entrada2;
			
			//operação SHIFT RIGHT
			4'b1001: saida = entrada1 >> entrada2;
			
			//operação SHIFT LEFT
			4'b1010: saida = entrada1 << entrada2;
			
			//operação IGUAL
			4'b1011:
				begin
					if (entrada1 == entrada2) 
					begin
						zeroflag = 1;
						saida = 1;
					end
					else 
					begin
						zeroflag = 0;
						saida = entrada2;
					end
				end
			
			//operação MAIOR QUE
			4'b1100:
				if (entrada1 > entrada2) saida = 1;
				else saida = 0;
			
			//operação MENOR QUE
			4'b1101:
				if (entrada1 < entrada2) saida = 1;
				else saida = 0;

			//operação auxiliar
			4'b1110: saida = entrada2;
			
			default: saida = entrada1;

		endcase
		
	end
endmodule
