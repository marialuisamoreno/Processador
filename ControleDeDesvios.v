/*Unidade de Controle de Desvios do Processador*/

module ControleDeDesvios (comando, clock, ZeroFlag, imediato,
								  ProgramCounter, saida, saidaULA, Reset);
	//Program Counter das operações jump
	input [31:0] ProgramCounter;
	//Endereços do local de desvio
	input wire [31:0] saidaULA, imediato;
	//Flag para indicar qual operação fazer0,
	input [1:0] comando;
	//Flags para as operações Branch On Equal e Jump
	input ZeroFlag, Reset;
	//Sinal do clock
	input clock;
	//Saida da unidade de desvios
	output reg [31:0] saida;
	
	always @ (posedge clock) 
	begin
		case(comando)
		   //Incremento o PC
			2'b00: saida = ProgramCounter + 1;
	      //Operação de Branch On Equal
			2'b01: 
				begin
					if(ZeroFlag == 1 || saidaULA == 1) saida = imediato;
					else saida = ProgramCounter + 1;
				end
			//Operação de Jump
			2'b10: saida = saidaULA;
			//Break
			2'b11: saida = ProgramCounter;
		endcase
		
		//Se o reset for solicitado, a saída é ressetada
		if (Reset == 1) saida <= 0;
	end
endmodule
