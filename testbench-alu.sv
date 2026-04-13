module test();
	logic clk,reset;
	logic [3:0] a, rawb;
    logic [2:0] funcsel;
    logic [3:0] result;
    logic overflow, isZero, isNegative;
	logic [3:0] resultExpected;
    logic overflowExpected, isZeroExpected, isNegativeExpected;
	logic [31:0] testIndex, errors;
	logic [42:0] testvectors [100:0];

	module_alu m1(.a(a), .rawb(rawb), .funcsel(funcsel), .result(result), .overflow(overflow), .isZero(isZero), .isNegative(isNegative));
	
	always
	begin
		clk=1; #5; clk=0; #5;
	end

	initial
	begin
		$readmemb ("alu_testcase.txt", testvectors);
		testIndex =0;
		errors=0;
		reset =1; #27; reset=0;
	end

	always @ (posedge clk)
	begin
		#1; {a, rawb, funcsel, resultExpected, overflowExpected, isZeroExpected, isNegativeExpected} = testvectors [testIndex];
	end

	always @(negedge clk)
	begin
		if (~reset)
		begin
			if (result!==resultExpected)
			begin
				$display("Error result: inputs = a:%b, rawb:%b, funcsel:%b", a, rawb, funcsel);
				$display(" result = %b (%b expected)", result, resultExpected);
				errors = errors+1;
			end
			if (overflow!==overflowExpected)
			begin
				$display("Error result: inputs = a:%b, rawb:%b, funcsel:%b", a, rawb, funcsel);
				$display("(%b) overflow = %b (%b expected)", result, overflow, overflowExpected);
				errors = errors+1;
			end
			if (isZero!==isZeroExpected)
			begin
				$display("Error result: inputs = a:%b, rawb:%b, funcsel:%b", a, rawb, funcsel);
				$display("(%b) isZero = %b (%b expected)", result, isZero, isZeroExpected);
				errors = errors+1;
			end
			if (isNegative!==isNegativeExpected)
			begin
				$display("Error result: inputs = a:%b, rawb:%b, funcsel:%b", a, rawb, funcsel);
				$display("(%b) isNegative = %b (%b expected)", result, isNegative, isNegativeExpected);
				errors = errors+1;
			end
			testIndex = testIndex+1;
			if (testvectors[testIndex]===43'bx)
			begin
				$display("%d tests completed with %d errors", testIndex, errors);
				$stop;
			end
		end
	end
endmodule
