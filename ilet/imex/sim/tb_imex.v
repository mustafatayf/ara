`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TAYF ARGEM
// Engineer: mustafa
// 
// Create Date: 07/29/2023 06:02:31 PM
// Design Name: 
// Module Name: tb_imex
// Project Name: import and export data example 
// Target Devices: 
// Tool Versions: 
// Description:  >>> import data from txt file to hardware design
//               <<< export data to txt file from hardware design
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_imex();
    
    parameter PERIOD = 10; // clock periyodu ( 4ns < )
    parameter DATA_WIDTH = 8; // data width
    parameter OUT_FILE_PATH = "/home/ws_xilinx/imge/o_demo_file.txt";
        
    reg tb_clk;
    reg tb_rst;
    //reg START;

    integer  dm1, dm2;
    integer  ret;
    integer  file_read;
    integer  file_write;
    
    reg                    i_valid;
    reg [DATA_WIDTH-1:0]   i_r;
    reg [DATA_WIDTH-1:0]   i_g;
    reg [DATA_WIDTH-1:0]   i_b;
    
    wire [3*DATA_WIDTH-1:0]   in_data;
    wire [3*DATA_WIDTH-1:0]   out_px;
    
    always begin
      tb_clk = 1'b1;
      #(PERIOD/2) tb_clk = 1'b0;
      #(PERIOD/2);
    end  
             
    
    initial begin
        tb_rst = 0;
//        #(PERIOD*3)
        #47
        tb_rst = 1;
        #71
//        #(PERIOD*5)
        tb_rst = 0;
        
        //  file to write
        file_write = $fopen(OUT_FILE_PATH,"w");  // write to the file "w"
        
        // file to read from
        file_read = $fopen("/home/ws_xilinx/imge/i_demo_file.txt", "r");
        #(PERIOD/2)
        // https://stackoverflow.com/a/47120534
        i_valid = 1'b1;
        while(! $feof(file_read)) begin // read until the end-of-file 
            ret = $fscanf(file_read,"%h %h %h\n", i_r, i_g, i_b); 
            #PERIOD;
        end
        i_valid = 1'b0;
        $fclose(file_read);  // close the file
        #(PERIOD*10);
        $stop;  
        // $finish     
    end
    

    always @(posedge DUT.clk)
    begin
     if(DUT.valid)
         begin
//             $fwrite(file_write,"%h\t%h\t%h\n",DUT.px_r, DUT.px_g, DUT.px_b); 
             $fwrite(file_write,"%h %h %h\n", out_px[3*DATA_WIDTH-1:2*DATA_WIDTH], out_px[2*DATA_WIDTH-1:DATA_WIDTH], out_px[DATA_WIDTH-1:0]); 
             $fclose(file_write);
             #2
             file_write = $fopen(OUT_FILE_PATH,"a"); //append to the file "a"
        end
    end
    
    assign in_data = {i_r, i_g, i_b};

    top_imex #(
        .DW(3*DATA_WIDTH)
    ) DUT(
            .clk(tb_clk),
            .rst(tb_rst),
            .i_valid(i_valid),
            .i_data(in_data),
            .o_valid(o_valid),
            .o_data(out_px),
            .o_error()
        );


endmodule