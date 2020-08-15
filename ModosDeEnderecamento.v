/*Modos de Endereçamento do Processador*/

module ModosDeEnderecamento (controle, instrucao, RA, RB, RC);
	//Tirando o opcode, a instrução tem 27 bits
	input [26:0] instrucao;
	//Flag para indicar qual modo de endereçamento irá ser utilizado
	input [1:0] controle;
	//De saida temos cada registrador de tamanho de 9 bits
	output reg [8:0] RA, RB, RC;
	
	always @ (controle or instrucao) 
	begin
		RC = 0;
		RA = 0;
		RB = 0;
		
		case(controle)
			//Instrução do Tipo I
			2'b00:
				begin
					RA = instrucao[26:18];
					RB = instrucao[17:9];					
				end
			//Instrução do Tipo J
			2'b01:
				begin
					RB = instrucao[26:18];
				end
			//Instrução do Tipo R
			2'b10: 
				begin
					RC = instrucao[26:18];
					RA = instrucao[17:9];
					RB = instrucao[8:0];
				end
			//Instrução do Tipo J*
			2'b11:
				begin
					RC = instrucao[26:18];
					RB = instrucao[17:9];
				end	
			//Default
			default: 
				begin
					RC = 0;
					RA = 0;
					RB = 0;
				end
		endcase
	end
endmodule
