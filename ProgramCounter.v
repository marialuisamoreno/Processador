/*Program Counter do Processador*/

module ProgramCounter (clock, BreakFlag, NopFlag, Reset, EntradaPC, SaidaPC);
	//Flags para as ações de break de nop (sem operação)
	input NopFlag, BreakFlag;
	//Variáveis para reset e sinal do clock
	input Reset, clock;
	//Entrada do Program Counter
	input [31:0] EntradaPC;
	//Saída do Program Counter
	output reg [31:0] SaidaPC;

	always @ (posedge clock) 
	begin
		//A saída recebe a entrada que já foi incrementada no Controle de Desvios
		SaidaPC <= EntradaPC;
		//Se o reset for solicitado, a saída é ressetada
		if (Reset == 1) SaidaPC <= 0;
		//Se  for "sem operação", a saída se mantém
		if (NopFlag==1) SaidaPC <= EntradaPC;
		//Se for solicitado a interrupção do sistema, o PC é reiniciado
		else if (BreakFlag == 1) SaidaPC <= 0;
	end
	
endmodule
