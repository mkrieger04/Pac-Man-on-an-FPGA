module tinky 
( 
    input logic won, lost,
    input  logic        Reset, 
    input  logic        frame_clk,
    input logic [3:0] collide,
    input  logic [9:0]  pacX,
    input logic [9:0] pacY,
    input logic eat_time,
    output logic [9:0]  BallX, 
    output logic [9:0]  BallY, 
    output logic [9:0]  BallS 
);
    

	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=235;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=208;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=431;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=96;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=383;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    logic [9:0] Ball_X_Motion;
    logic [9:0] Ball_X_Motion_next;
    logic [9:0] Ball_Y_Motion;
    logic [9:0] Ball_Y_Motion_next;
    logic [3:0] last_key; //WSAD
    logic [9:0] Ball_X_next;
    logic [9:0] Ball_Y_next;
    logic [7:0] keycode;
    logic[3:0] last_key_next;

    always_comb begin
        Ball_Y_Motion_next = Ball_Y_Motion; // set default motion to be same as prev clock cycle 
        Ball_X_Motion_next = Ball_X_Motion;
        last_key_next = last_key;

        //modify to control ball motion with the keycode
        if((pacX > BallX))
        begin
            if (eat_time) last_key_next = 4'b0010;
            else last_key_next = 4'b0001;
        end
        else if ((pacX < BallX))
        begin
            if (eat_time) last_key_next = 4'b0001;
            else last_key_next = 4'b0010;
        end
        else if (pacY < BallY)
        begin
            if (eat_time) last_key_next = 4'b0100;
            else last_key_next = 4'b1000;
        end
        else if (pacY > BallY)
        begin
            if (eat_time) last_key_next = 4'b1000;
            last_key_next = 4'b0100;
        end
        
        
        
        
        
 //row 1
        if(BallY == 8'h83)
           begin
            if((BallX == 8'hdc) || (BallX == 12'h14c))
            begin
                if(last_key == 4'b0100)
                begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0; 
                end
                if(last_key == 4'b0001)
                begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd1;
                end
                if((last_key == 4'b1000) || (last_key == 4'b0010))
                begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0;
                end
            end
            
//            if(((BallX > 8'hdc) && (BallX < 12'h104)) || ((BallX > 12'h104) && (BallX < 12'h134)) || ((BallX > 12'h14c) && (BallX < 12'h17c)) || ((BallX > 12'h17c) && (BallX < 12'h1a4)))
//            begin
//                if(last_key == 4'b0010)
//                begin
//                    Ball_Y_Motion_next = 10'd0;
//                    Ball_X_Motion_next = -10'd1; 
//                end
//                if(last_key == 4'b0001)
//                begin
//                    Ball_Y_Motion_next = 10'd0;
//                    Ball_X_Motion_next = 10'd1;
//                end
//            end
            
            if((BallX == 12'h104) || (BallX == 12'h17c))
            begin
                if(last_key == 4'b0010)
                begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1; 
                end
                if(last_key == 4'b0001)
                begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd1;
                end
                if(last_key == 4'b0100)
                begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0; 
                end
                if((last_key == 4'b1000) && (Ball_Y_Motion_next == -10'd1))
                begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd0;            
                end
            end
           
           if((BallX == 12'h134) || (BallX == 12'h1a4))
            begin
                if(last_key == 4'b0010)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1;
                    end
                 if(last_key == 4'b0100)
                    begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0;                   
                    end
                  if((last_key == 4'b1000) || (last_key == 4'b0001))
                    begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0;
                    end
            end    
            end        
           
            if((BallY > 8'h83) && (BallY < 8'ha3))
                begin
                    if(last_key == 4'b1000)
                    begin
                      Ball_Y_Motion_next = -10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                    if(last_key == 4'b0100)
                    begin
                      Ball_Y_Motion_next = 10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                end
                     
       ///row 2        
            if(BallY == 8'ha3)
            begin
//                if(((BallX > 8'hdc) && (BallX < 12'h104)) || ((BallX > 12'h104) && (BallX < 12'h11c)) || ((BallX > 12'h11c) && (BallX < 12'h134)) || ((BallX > 12'h134) && (BallX < 12'h14c)) || ((BallX > 12'h14c) && (BallX < 12'h164)) || ((BallX > 12'h164) && (BallX < 12'h17c)) || ((BallX > 12'h17c) && (BallX < 12'h1a4)))
//                begin
//                    if(last_key == 4'b0010)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = -10'd1; 
//                     end
//                    if(last_key == 4'b0001)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = 10'd1;
//                    end                                
//                  end
                
                  if(BallX == 8'hdc)
                  begin
                    if(last_key == 4'b1000)
                    begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0; 
                     end
                    if(last_key == 4'b0100)
                    begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0; 
                     end
                    if(last_key == 4'b0001)
                    begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                    end       
                    if((last_key == 4'b0010) && Ball_X_Motion_next == -10'd1)   
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0; 
                        end         
                  end
                  
                  if((BallX == 12'h104) || (BallX == 12'h17c))
                    begin
                    if(last_key == 4'b1000)
                    begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0; 
                     end
                    if(last_key == 4'b0100)
                    begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0; 
                     end
                    if(last_key == 4'b0001)
                    begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                    end       
                    if((last_key == 4'b0010))   
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = -10'd1; 
                        end                      
                    end
                if((BallX == 12'h11c) || (BallX == 12'h164))
                begin
                    if(last_key == 4'b0010)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1; 
                    end
                    if(last_key == 4'b0001)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd1;
                    end
                    if(last_key == 4'b0100)
                    begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0; 
                    end
                    if((last_key == 4'b1000) && (Ball_Y_Motion_next == -10'd1))
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd0;            
                    end     
                end
                //3U
                if((BallX == 12'h134) || (BallX == 12'h14c))
                begin
                    if(last_key == 4'b0010)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1; 
                    end
                    if(last_key == 4'b0001)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd1;
                    end
                    if(last_key == 4'b1000)
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0; 
                    end
                    if((last_key == 4'b0100) && (Ball_Y_Motion_next == 10'd1))
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd0;            
                    end
                end
                //3L
                if(BallX == 12'h1a4)
                begin
                    if(last_key == 4'b0010)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1; 
                    end
                    if(last_key == 4'b0100)
                    begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0;
                    end
                    if(last_key == 4'b1000)
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0; 
                    end
                    if((last_key == 4'b0001) && (Ball_X_Motion_next == 10'd1))
                    begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0;            
                    end                      
                 end       
             end
            if((BallY > 8'ha3) && (BallY < 8'hbb))
              begin
                    if(last_key == 4'b1000)
                    begin
                      Ball_Y_Motion_next = -10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                    if(last_key == 4'b0100)
                    begin
                      Ball_Y_Motion_next = 10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
              end
          //row3          
              if(BallY == 8'hbb)
              begin
//                if(((BallX > 8'hdc) && (BallX < 12'h104)) || ((BallX > 12'h11c) && (BallX < 12'h134)) || ((BallX > 12'h14c) && (BallX < 12'h164)) || ((BallX > 12'h17c) && (BallX < 12'h1a4)))
//                  begin
//                    if(last_key == 4'b0010)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = -10'd1; 
//                     end
//                    if(last_key == 4'b0001)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = 10'd1;
//                    end               
//                   end
                  
                 if((BallX == 8'hdc) || (BallX == 12'h11c))
                    begin
                    if(last_key == 4'b1000)
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0; 
                        end
                    if(last_key == 4'b0001)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                        end
                    if(((last_key == 4'b0100)) || ((last_key == 4'b0010)))
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0;
                    end
                    end
                   
                  if((BallX == 12'h104))
                   begin
                    if(last_key == 4'b0010)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1; 
                    end
                    if(last_key == 4'b0100)
                    begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0;
                    end
                    if(last_key == 4'b1000)
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0; 
                    end
                    if((last_key == 4'b0001) && (Ball_X_Motion_next == 10'd1))
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0;            
                    end 
                   end
                   
                   if(BallX == 12'h134)
                    begin
                        if(last_key == 4'b0010)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = -10'd1; 
                            end
                        if(last_key == 4'b0100)
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0; 
                            end 
                            if(((last_key == 4'b1000)) || ((last_key == 4'b0001)))
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end
                    end
                   
                   if(BallX == 12'h14c)
                    begin
                        if(last_key == 4'b0001)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd1; 
                            end
                        if(last_key == 4'b0100)
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0; 
                            end 
                        if(((last_key == 4'b1000)) || ((last_key == 4'b0010)))
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end                      
                    end
                   
                   if((BallX == 12'h164) || (BallX == 12'h1a4))
                    begin
                        if(last_key == 4'b0010)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = -10'd1; 
                            end
                        if(last_key == 4'b1000)
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0; 
                            end 
                        if(((last_key == 4'b0100)) || ((last_key == 4'b0001)))
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end                        
                    end
                    
                    if(BallX == 12'h17c)
                    begin
                        if(last_key == 4'b1000)
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0; 
                        end
                        if(last_key == 4'b0100)
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0; 
                        end
                        if(last_key == 4'b0001)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                        end       
                        if((last_key == 4'b0010) && Ball_X_Motion_next == -10'd1)   
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0; 
                        end                       
                      end        
              end
 
 
            if((BallY > 8'hbb) && (BallY < 8'hd3))
              begin
                    if(last_key == 4'b1000)
                    begin
                      Ball_Y_Motion_next = -10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                    if(last_key == 4'b0100)
                    begin
                      Ball_Y_Motion_next = 10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
              end
              
         //row 4
            if(BallY == 8'hd3)
            begin
//                if(((BallX > 12'h11c) && (BallX < 12'h134)) || ((BallX > 12'h134) && (BallX < 12'h14c)) || ((BallX > 12'h14c) && (BallX < 12'h164)))
//                begin
//                    if(last_key == 4'b0010)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = -10'd1; 
//                     end
//                    if(last_key == 4'b0001)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = 10'd1;
//                    end              
//                  end

                if(BallX == 12'h140)
                 begin
                    if(last_key == 4'b0010)
                    begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = -10'd1; 
                     end
                    if(last_key == 4'b0001)
                    begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                    end              
                  end 
                if(BallX == 12'h11c)
                    begin
                        if(last_key == 4'b0100)
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end
                         if(last_key == 4'b0001)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd1;
                            end
                          if(((last_key == 4'b1000)) || ((last_key == 4'b0010)))
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end
                    end
                    
                 if((BallX == 12'h134) || (BallX == 12'h14c))
                    begin
                    if(last_key == 4'b0010)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1; 
                    end
                    if(last_key == 4'b0001)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd1;
                    end
                    if(last_key == 4'b1000)
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0; 
                    end
                    if((last_key == 4'b0100) && (Ball_Y_Motion_next == 10'd1))
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd0;            
                    end                    
                    end
                    
                  if(BallX == 12'h164)
                    begin
                        if(last_key == 4'b0100)
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end
                         if(last_key == 4'b0010)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = -10'd1;
                            end
                         if(((last_key == 4'b1000)) || ((last_key == 4'b0001)))
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end                                                     
                    end
            end
            
            
            
           if((BallY > 8'hd3) && (BallY < 8'heb))
              begin
                    if(last_key == 4'b1000)
                    begin
                      Ball_Y_Motion_next = -10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                    if(last_key == 4'b0100)
                    begin
                      Ball_Y_Motion_next = 10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
              end
            
            //row 5
            //this fuckerry
            if(BallY == 8'heb)
              begin
//                  if(((BallX > 12'h104) && (BallX < 12'h11c)) || ((BallX > 12'h164) && (BallX < 12'h17c)))  
//                  begin
//                    if(last_key == 4'b0010)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = -10'd1; 
//                     end
//                    if(last_key == 4'b0001)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = 10'd1;
//                    end    
//                  end
                    if(BallX == 12'h140)
                    begin
                    if(pacX != 12'h141 || pacY != 12'h133)
                    begin
                    if(eat_time)
                    begin 
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd0;
                    end 
                    else
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0;
                    end
                    end
                    end
                  
                  if((BallX == 12'h104) || (BallX == 12'h164))
                    begin
                    if(last_key == 4'b1000)
                    begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0; 
                     end
                    if(last_key == 4'b0100)
                    begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0; 
                     end
                    if(last_key == 4'b0001)
                    begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                    end       
                    if((last_key == 4'b0010) && Ball_X_Motion_next == -10'd1)   
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0; 
                        end                   
                    end
              
                if((BallX == 12'h11c) || (BallX == 12'h17c))
                    begin
                    if(last_key == 4'b0010)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1; 
                    end
                    if(last_key == 4'b0100)
                    begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0;
                    end
                    if(last_key == 4'b1000)
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0; 
                    end
                    if((last_key == 4'b0001) && (Ball_X_Motion_next == 10'd1))
                    begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0;            
                    end  
                    end
              end
              
            if((BallY > 8'heb) && (BallY < 12'h103))
              begin
                    if(last_key == 4'b1000)
                    begin
                      Ball_Y_Motion_next = -10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                    if(last_key == 4'b0100)
                    begin
                      Ball_Y_Motion_next = 10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
              end      
           //row6
           if(BallY == 12'h103)
            begin
//                if((BallX > 12'h11c) && (BallX < 12'h164))
//                begin
//                    if(last_key == 4'b0010)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = -10'd1; 
//                     end
//                    if(last_key == 4'b0001)
//                    begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = 10'd1;
//                    end               
//                end
                
                if(BallX == 12'h11c)
                    begin
                    if(last_key == 4'b1000)
                    begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0; 
                     end
                    if(last_key == 4'b0100)
                    begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0; 
                     end
                    if(last_key == 4'b0001)
                    begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                    end       
                    if((last_key == 4'b0010) && Ball_X_Motion_next == -10'd1)   
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0; 
                        end                      
                    end
                 
                 if(BallX == 12'h164)
                    begin
                    if(last_key == 4'b0010)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1; 
                    end
                    if(last_key == 4'b0100)
                    begin
                    Ball_Y_Motion_next = 10'd1;
                    Ball_X_Motion_next = 10'd0;
                    end
                    if(last_key == 4'b1000)
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0; 
                    end
                    if((last_key == 4'b0001) && (Ball_X_Motion_next == 10'd1))
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0;            
                    end                   
                    end
            end
            
            
           if((BallY > 12'h103) && (BallY < 12'h11b))
              begin
                    if(last_key == 4'b1000)
                    begin
                      Ball_Y_Motion_next = -10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                    if(last_key == 4'b0100)
                    begin
                      Ball_Y_Motion_next = 10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
              end 
              
            //row7
            if(BallY == 12'h11b)
                begin
//                if(((BallX > 8'hdc) && (BallX < 12'h104)) || ((BallX > 12'h104) && (BallX < 12'h11c)) || ((BallX > 12'h11c) && (BallX < 12'h134)) || ((BallX > 12'h14c) && (BallX < 12'h164)) || ((BallX > 12'h164) && (BallX < 12'h17c)) || ((BallX > 12'h17c) && (BallX < 12'h1a4)))
//                begin
//                    if(last_key == 4'b0010)
//                        begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = -10'd1; 
//                        end
//                    if(last_key == 4'b0001)
//                        begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = 10'd1;
//                        end                                
//                  end
                  
                  if((BallX == 8'hdc) || (BallX == 12'h14c))
                    begin
                        if(last_key == 4'b0100)
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0001)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                        end
                        if(((last_key == 4'b1000)) || ((last_key == 4'b0010)))
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end  
                    end
                    
                    if((BallX == 12'h104) || (BallX == 12'h17c))
                        begin
                        if(last_key == 4'b0100)
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0001)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                        end
                        if(last_key == 4'b1000)
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0010)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = -10'd1;
                        end    
                        end
                      
                      if((BallX == 12'h11c) || (BallX == 12'h164))
                        begin
                            if(last_key == 4'b0010)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = -10'd1; 
                            end
                            if(last_key == 4'b0001)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd1;
                            end
                            if(last_key == 4'b1000)
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0; 
                            end
                            if((last_key == 4'b0100) && (Ball_Y_Motion_next == 10'd1))
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd0;            
                            end
                        end
                  
                       if((BallX == 12'h134) || (BallX == 12'h1a4))
                        begin
                        if(last_key == 4'b0100)
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0010)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = -10'd1;
                        end
                        if(((last_key == 4'b1000)) || ((last_key == 4'b0001)))
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end                     
                        end
                end
 
            if((BallY > 12'h11b) && (BallY < 12'h133))
              begin
                    if(last_key == 4'b1000)
                    begin
                      Ball_Y_Motion_next = -10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                    if(last_key == 4'b0100)
                    begin
                      Ball_Y_Motion_next = 10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
              end 
           //row 8   
            if(BallY == 12'h133)
                begin
//                    if(((BallX > 8'hdc) && (BallX < 8'hec)) || ((BallX > 12'h104) && (BallX < 12'h11c)) || ((BallX > 12'h11c) && (BallX < 12'h134)) || ((BallX > 12'h134) && (BallX < 12'h14c)) || ((BallX > 12'h14c) && (BallX < 12'h164)) || ((BallX > 12'h164) && (BallX < 12'h17c)) || ((BallX > 12'h194) && (BallX < 12'h1a4))) 
//                        begin
//                        if(last_key == 4'b0010)
//                        begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = -10'd1; 
//                        end
//                        if(last_key == 4'b0001)
//                        begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = 10'd1;
//                        end                         
//                        end
                        
                    if(BallX == 8'hdc)
                        begin
                            if(last_key == 4'b1000)  
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0;    
                            end
                            if(last_key == 4'b0001)  
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd1;
                            end
                            if(((last_key == 4'b0100) ) || ((last_key == 4'b0010)))
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end
                        end
                        
                       if(BallX == 8'hec)
                        begin
                            if(last_key == 4'b0100)  
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;    
                            end
                            if(last_key == 4'b0010)  
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = -10'd1;
                            end
                            if(((last_key == 4'b1000) ) || ((last_key == 4'b0001)))
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end
                        end
                        
                        if(BallX == 12'h104)
                            begin
                            if(last_key == 4'b1000)
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0; 
                            end
                            if(last_key == 4'b0100)
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0; 
                            end
                            if(last_key == 4'b0001)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd1;
                            end       
                            if((last_key == 4'b0010) && Ball_X_Motion_next == -10'd1)   
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0; 
                            end                            
                            end
                            
                         if((BallX == 12'h11c) || (BallX == 12'h164))
                            begin
                            if(last_key == 4'b0010)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = -10'd1; 
                            end
                            if(last_key == 4'b0001)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd1;
                            end
                            if(last_key == 4'b0100)
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0; 
                            end
                            if((last_key == 4'b1000) && (Ball_Y_Motion_next == -10'd1))
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd0;            
                            end                            
                            end
                            
                         if((BallX == 12'h134) || (BallX == 12'h14c))
                            begin
                            if(last_key == 4'b0010)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = -10'd1; 
                            end
                            if(last_key == 4'b0001)
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd1;
                            end
                            if(last_key == 4'b1000)
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0; 
                            end
                            if((last_key == 4'b0100) && (Ball_Y_Motion_next == 10'd1))
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd0;            
                            end                            
                            end
                           
                          if(BallX == 12'h17c)
                            begin
                                if(last_key == 4'b0010)
                                begin
                                Ball_Y_Motion_next = 10'd0;
                                Ball_X_Motion_next = -10'd1; 
                                end
                                if(last_key == 4'b0100)
                                begin
                                Ball_Y_Motion_next = 10'd1;
                                Ball_X_Motion_next = 10'd0;
                                end
                                if(last_key == 4'b1000)
                                begin
                                Ball_Y_Motion_next = -10'd1;
                                Ball_X_Motion_next = 10'd0; 
                                end
                                if((last_key == 4'b0001) && (Ball_X_Motion_next == 10'd1))
                                begin
                                Ball_Y_Motion_next = -10'd1;
                                Ball_X_Motion_next = 10'd0;            
                                end                       
                             end
                             
                          if(BallX == 12'h194)
                            begin
                            if(last_key == 4'b0100)  
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;    
                            end
                            if(last_key == 4'b0001)  
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = 10'd1;
                            end
                            if(((last_key == 4'b1000)) || ((last_key == 4'b0010)))
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end
                            end
                            
                            if(BallX == 12'h1a4)
                            begin
                            if(last_key == 4'b1000)  
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0;    
                            end
                            if(last_key == 4'b0010)  
                            begin
                            Ball_Y_Motion_next = 10'd0;
                            Ball_X_Motion_next = -10'd1;
                            end
                            if(((last_key == 4'b0100) ) || ((last_key == 4'b0001) ))
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end
                            end     
                end
            if((BallY > 12'h133) && (BallY < 12'h14b))
              begin
                    if(last_key == 4'b1000)
                    begin
                      Ball_Y_Motion_next = -10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                    if(last_key == 4'b0100)
                    begin
                      Ball_Y_Motion_next = 10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
              end  
              //row9
              if(BallY == 12'h14b)
                begin
//                    if(((BallX > 8'hdc) && (BallX < 8'hec)) || ((BallX > 8'hec) && (BallX < 12'h104)) || ((BallX > 12'h11c) && (BallX < 12'h134)) || ((BallX > 12'h14c) && (BallX < 12'h164)) || ((BallX > 12'h17c) && (BallX < 12'h194)) || ((BallX > 12'h194) && (BallX < 12'h1a4)))
//                        begin
//                        if(last_key == 4'b0010)
//                        begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = -10'd1; 
//                        end
//                        if(last_key == 4'b0001)
//                        begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = 10'd1;
//                        end                     
//                        end
                        
                      if((BallX == 8'hdc) || (BallX == 12'h14c))
                      begin
                        if(last_key == 4'b0100)
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0001)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                        end
                        if(((last_key == 4'b1000) ) || ((last_key == 4'b0010) ))
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end                    
                      end
                      
                      if((BallX == 8'hec) || (BallX == 12'h194))
                      begin
                        if(last_key == 4'b0010)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = -10'd1; 
                        end
                        if(last_key == 4'b0001)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                        end
                        if(last_key == 4'b1000)
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0; 
                        end
                        if((last_key == 4'b0100) && (Ball_Y_Motion_next == 10'd1))
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd0;            
                        end                     
                        end
                        
                      if((BallX == 12'h104) || (BallX == 12'h164))
                      begin
                        if(last_key == 4'b1000)
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0010)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = -10'd1;
                        end
                        if(((last_key == 4'b0100)) || ((last_key == 4'b0001)))
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end                    
                      end
                      
                      if((BallX == 12'h11c) || (BallX == 12'h17c))
                      begin
                        if(last_key == 4'b1000)
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0001)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                        end
                        if(((last_key == 4'b0100)) || ((last_key == 4'b0010) ))
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end
                      end
                      
                      if((BallX == 12'h134) || (BallX == 12'h1a4))
                      begin
                        if(last_key == 4'b0100)
                        begin
                        Ball_Y_Motion_next = 10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0010)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = -10'd1;
                        end
                        if(((last_key == 4'b1000)) || ((last_key == 4'b0001) ))
                            begin
                            Ball_Y_Motion_next = 10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end                     
                      end                  
                end
 
  if((BallY > 12'h14b) && (BallY < 12'h163))
              begin
                    if(last_key == 4'b1000)
                    begin
                      Ball_Y_Motion_next = -10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
                    if(last_key == 4'b0100)
                    begin
                      Ball_Y_Motion_next = 10'd1;
                      Ball_X_Motion_next = 10'd0;  
                    end
              end  
    //row 10          
  if(BallY == 12'h163)
    begin
//        if(((BallX > 8'hdc) && (BallX < 12'h134)) || ((BallX > 12'h134) && (BallX < 12'h14c)) || ((BallX > 12'h14c) && (BallX < 12'h1a4)))
//            begin
//                        if(last_key == 4'b0010)
//                        begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = -10'd1; 
//                        end
//                        if(last_key == 4'b0001)
//                        begin
//                        Ball_Y_Motion_next = 10'd0;
//                        Ball_X_Motion_next = 10'd1;
//                        end                
//            end
        if(BallX == 8'hdc)
        begin
                        if(last_key == 4'b1000)
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0001)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = 10'd1;
                        end
                        if(((last_key == 4'b0100) ) || ((last_key == 4'b0010) ))
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end         
        end
        
        if((BallX == 12'h134) || (BallX == 12'h14c))
            begin
                    if(last_key == 4'b0010)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = -10'd1; 
                    end
                    if(last_key == 4'b0001)
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd1;
                    end
                    if(last_key == 4'b1000)
                    begin
                    Ball_Y_Motion_next = -10'd1;
                    Ball_X_Motion_next = 10'd0; 
                    end
                    if((last_key == 4'b0100) && (Ball_Y_Motion_next == 10'd1))
                    begin
                    Ball_Y_Motion_next = 10'd0;
                    Ball_X_Motion_next = 10'd0;            
                    end            
            end
            
        if(BallX == 12'h1a4)
        begin
                        if(last_key == 4'b1000)
                        begin
                        Ball_Y_Motion_next = -10'd1;
                        Ball_X_Motion_next = 10'd0;
                        end
                        if(last_key == 4'b0010)
                        begin
                        Ball_Y_Motion_next = 10'd0;
                        Ball_X_Motion_next = -10'd1;
                        end
                        if(((last_key == 4'b0100)) || ((last_key == 4'b0001) ))
                            begin
                            Ball_Y_Motion_next = -10'd1;
                            Ball_X_Motion_next = 10'd0;
                            end       
        end
    end
 
    end

    assign BallS = 8;  // default ball size                                                                                                        
    assign Ball_X_next = (BallX + Ball_X_Motion_next);                                                                                             
    assign Ball_Y_next = (BallY + Ball_Y_Motion_next);                                                                                             
    int slow;                                                                                                                                               
    always_ff @(posedge frame_clk) //make sure the frame clock is instantiated correctly                                                           
    begin: Move_Ball                                                                                                                               
        if (Reset)                                                                                                                                 
        begin                                                                                                                                      
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;                                                                                                 
			Ball_X_Motion <= 10'd0; //Ball_X_Step;                                                                                                          
            last_key = 4'b0000;                                                                                                                    
			BallY <= Ball_Y_Center;                                                                                                                         
			BallX <= Ball_X_Center;   
			slow = 0;                                                                                                                      
        end 
        else if (won == 1'b1 || lost == 1'b1)
        begin                                                                                                                                      
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;                                                                                                 
			Ball_X_Motion <= 10'd0; //Ball_X_Step;                                                                                                          
            last_key = 4'b0000;                                                                                                                    
			BallY <= Ball_Y_Center;                                                                                                                         
			BallX <= Ball_X_Center;   
			slow = 0;                                                                                                                      
        end  
        else if (collide == 4'b0010 || collide == 4'b0001) 
        begin
            BallY <= Ball_Y_Center;                                                                                                                      
			BallX <= Ball_X_Center;
			Ball_Y_Motion <= 10'd0; //Ball_Y_Step;                                                                                                 
			Ball_X_Motion <= 10'd0; //Ball_X_Step;                                                                                                          
            last_key = 4'b0000; 
        end                                                                                                                                         
        else                                                                                                                                       
        begin                                                                                                                                      
            if (slow == 1 || slow == 2)
            begin                                                                                                                                       
			Ball_Y_Motion <= Ball_Y_Motion_next;                                                                                                            
			Ball_X_Motion <= Ball_X_Motion_next;                                                                                                            
            last_key = last_key_next;                                                                                                              
            BallY <= Ball_Y_next;  // Update ball position                                                                                         
            BallX <= Ball_X_next;    
            if (slow == 1) slow++;
            else if (slow == 2) slow = 0;
            end
            else slow++;                                                                                                           
			                                                                                                                                                
		end                                                                                                                                              
    end   


    
      
endmodule


// module tinky(
//    input  logic        Reset, 
//    input  logic        frame_clk,
//    input  logic [7:0]  keycode,

//    output logic [9:0]  BallX, 
//    output logic [9:0]  BallY, 
//    output logic [9:0]  BallS 
//    );
//     parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
//    parameter [9:0] Ball_Y_Center=211;  // Center position on the Y axis
//    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
//    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
//    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
//    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
//    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
//    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

//    logic [9:0] Ball_X_Motion;
//    logic [9:0] Ball_X_Motion_next;
//    logic [9:0] Ball_Y_Motion;
//    logic [9:0] Ball_Y_Motion_next;

//    logic [9:0] Ball_X_next;
//    logic [9:0] Ball_Y_next;

//    always_comb begin
//        Ball_Y_Motion_next = Ball_Y_Motion; // set default motion to be same as prev clock cycle 
//        Ball_X_Motion_next = Ball_X_Motion;

//        //modify to control ball motion with the keycode
//            if (keycode == 8'h0C)
//                begin
//                Ball_Y_Motion_next = -10'd1;
//                Ball_X_Motion_next = 10'd0;
//                end
            
//        if (keycode == 8'h0E) //S
//            begin
//            Ball_Y_Motion_next = 10'd1;
//            Ball_X_Motion_next = 10'd0;
//            end
        
//        if (keycode == 8'h0D) //A
//            begin
//            Ball_X_Motion_next = -10'd1;
//            Ball_Y_Motion_next = -10'd0;
//            end
        
//        if (keycode == 8'h0F) //D
//            begin
//            Ball_X_Motion_next = 10'd1;
//            Ball_Y_Motion_next = 10'd0;
//            end


//        if ( (BallY + BallS) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
//        begin
//            Ball_Y_Motion_next = (~ (Ball_Y_Step) + 1'b1);  // set to -1 via 2's complement.
//        end
//        else if ( (BallY - BallS) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
//        begin
//            Ball_Y_Motion_next = Ball_Y_Step;
//        end  
//       //fill in the rest of the motion equations here to bounce left and right
//       else if ( (BallX + BallS) >= Ball_X_Max ) 
//       begin
//            Ball_X_Motion_next = (~ (Ball_X_Step) + 1'b1);
//       end
       
//       else if ( (BallX - BallS) <= Ball_X_Min)
//       begin
//            Ball_X_Motion_next = Ball_X_Step;
//       end
//       //end modified
//    end

//    assign BallS = 16;  // default ball size
//    assign Ball_X_next = (BallX + Ball_X_Motion_next);
//    assign Ball_Y_next = (BallY + Ball_Y_Motion_next);
   
//    always_ff @(posedge frame_clk) //make sure the frame clock is instantiated correctly
//    begin: Move_Ball
//        if (Reset)
//        begin 
//            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
//			Ball_X_Motion <= 10'd1; //Ball_X_Step;
            
//			BallY <= Ball_Y_Center;
//			BallX <= Ball_X_Center;
//        end
//        else 
//        begin 

//			Ball_Y_Motion <= Ball_Y_Motion_next; 
//			Ball_X_Motion <= Ball_X_Motion_next; 

//            BallY <= Ball_Y_next;  // Update ball position
//            BallX <= Ball_X_next;
			
//		end  
//    end
//endmodule