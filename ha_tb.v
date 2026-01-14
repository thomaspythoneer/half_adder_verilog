module ha_tb();
  reg x,y; wire s,c; integer k;
  ha DUT(.sum(s), .carry(c),.a(x),.b(y));
  initial
    begin
      x=1'b0; y=1'b1;
      for (k=0;k<4;k=k+1)
        begin
          {x,y}=k;
          #5;
        end
    end
endmodule
