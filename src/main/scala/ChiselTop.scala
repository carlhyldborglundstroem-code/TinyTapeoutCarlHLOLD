import chisel3._
import chisel3.util._

/**
 * Example design in Chisel.
 * A redesign of the Tiny Tapeout example.
 */
class ChiselTop() extends Module {
  val io = IO(new Bundle {
    val ui_in = Input(UInt(8.W))      // Dedicated inputs
    val uo_out = Output(UInt(8.W))    // Dedicated outputs
    val uio_in = Input(UInt(8.W))     // IOs: Input path
    val uio_out = Output(UInt(8.W))   // IOs: Output path
    val uio_oe = Output(UInt(8.W))    // IOs: Enable path (active high: 0=input, 1=output)
  })

  io.uio_out := "b00000000".U
  io.uio_oe  := "b11111111".U
  ///////////////////////////
  // VALUE INITIALIZATIONS //
  ///////////////////////////
  
  val mode    = WireDefault(0.U(3.W))
  val fast    = RegInit(0.U(3.W))
  val medium  = RegInit(0.U(4.W))
  val slow    = RegInit(0.U(4.W))
  val tick2hz = RegInit(0.U(3.W))
  val tick1hz = RegInit(0.U(4.W))
  val cntReg  = RegInit(0.U(32.W))
  val sevSeg  = WireDefault("b11111111".U(8.W))
  val diceReg = RegInit(1.U(3.W))

  val seconds   = RegInit(0.U(6.W))
  val minutes   = RegInit(0.U(6.W))
  val hours     = RegInit(0.U(5.W))
  val days      = RegInit(0.U(9.W))
  val years     = RegInit(0.U(7.W)) 

  val pwmCount        = RegInit(0.U(4.W))
  val brightness      = RegInit(0.U(4.W))
  val changeDirection = RegInit(true.B)
  val ledStatus = pwmCount < brightness

  /////////////////////////////////////////////
  // Mode definition switch, MSB prioritized //
  /////////////////////////////////////////////
  when(io.ui_in(7)) {
    mode := 7.U
  } .elsewhen(io.ui_in(6)) {
    mode := 6.U
  } .elsewhen(io.ui_in(5)) {
    mode := 5.U
  } .elsewhen(io.ui_in(4)) {
    mode := 4.U
  } .elsewhen(io.ui_in(3)) {
    mode := 3.U
  } .elsewhen(io.ui_in(2)) {
    mode := 2.U
  } .elsewhen(io.ui_in(1)) {
    mode := 1.U
  } .elsewhen(io.ui_in(0)) {
    mode := 0.U
  }

  //////////////////
  // CLOCK THINGS //
  //////////////////
  cntReg := cntReg + 1.U
  diceReg := diceReg + 1.U
  when (diceReg === 7.U) {
    diceReg := 1.U
  }
  pwmCount := pwmCount + 1.U

  when (cntReg === 2500000.U) {   // fast - 10Hz
    cntReg := 0.U
    fast := fast + 1.U
    when (fast === 7.U) {         // fast goes from 0-7
      fast := 0.U
    }
    tick2hz := tick2hz + 1.U
    when (tick2hz === 4.U) {    // medium - 2Hz
      tick2hz := 0.U
      medium := medium + 1.U
      when (medium === 15.U) {  // medium goes from 0-15
        medium := 0.U
      }

      tick1hz := tick1hz + 1.U  // slow - 1Hz
      when (tick1hz === 1.U) {
        tick1hz := 0.U
        slow := slow + 1.U
        when (slow === 9.U) {   // slow goes from 0-9
          slow := 0.U
        }
        seconds := seconds + 1.U
        when (seconds === 59.U) {
          seconds := 0.U
          minutes := minutes + 1.U
          when (minutes === 59.U) {
            minutes := 0.U
            hours := hours + 1.U
            when (hours === 23.U) {
              hours := 0.U
              days := days + 1.U
              when (days === 364.U) {
                days := 0.U
                years := years + 1.U
              }
            }
          }
        }
      }
    }
  }

  //////////////////////////////
  // PRIMARY SWITCH STATEMENT //
  //////////////////////////////
  switch(mode) {

    //////////////////////////////////
    // MODE 0 - CLOCKWISE ANIMATION //
    //////////////////////////////////
    is(0.U) {
      switch(fast) {
        is(0.U) {sevSeg := "b00000001".U}
        is(1.U) {sevSeg := "b00000010".U}
        is(2.U) {sevSeg := "b00000100".U}
        is(3.U) {sevSeg := "b00001000".U}
        is(4.U) {sevSeg := "b00010000".U}
        is(5.U) {sevSeg := "b00100000".U}
        is(6.U) {sevSeg := "b01000000".U}
      }
    }

    /////////////////////////////////////////
    // MODE 1 - COUNTERCLOCKWISE ANIMATION //
    /////////////////////////////////////////
    is(1.U) {
      switch(fast) {
        is(6.U) {sevSeg := "b00000001".U}
        is(5.U) {sevSeg := "b00000010".U}
        is(4.U) {sevSeg := "b00000100".U}
        is(3.U) {sevSeg := "b00001000".U}
        is(2.U) {sevSeg := "b00010000".U}
        is(1.U) {sevSeg := "b00100000".U}
        is(0.U) {sevSeg := "b01000000".U}
      }
    }

    //////////////////////////
    // MODE 2 - COUNTER 0-9 //
    //////////////////////////
    is(2.U) {
      switch(slow) {
        is(0.U) {sevSeg := "b00111111".U}
        is(1.U) {sevSeg := "b00000110".U}
        is(2.U) {sevSeg := "b01011011".U}
        is(3.U) {sevSeg := "b01001111".U}
        is(4.U) {sevSeg := "b01100110".U}
        is(5.U) {sevSeg := "b01101101".U}
        is(6.U) {sevSeg := "b01111101".U}
        is(7.U) {sevSeg := "b00000111".U}
        is(8.U) {sevSeg := "b01111111".U}
        is(9.U) {sevSeg := "b01101111".U}
      }
    }

    //////////////////////////
    // MODE 3 - HELLO WORLD //
    //////////////////////////
    is(3.U) {
      switch(medium) {
        is(0.U) {sevSeg := "b01110110".U}  // H
        is(1.U) {sevSeg := "b01111001".U}  // E
        is(2.U) {sevSeg := "b00111000".U}  // L
        is(3.U) {sevSeg := "b00111000".U}  // L
        is(4.U) {sevSeg := "b00111111".U}  // O
        is(5.U) {sevSeg := "b00000000".U}  // 
        is(6.U) {sevSeg := "b01101010".U}  // W
        is(7.U) {sevSeg := "b00111111".U}  // O
        is(8.U) {sevSeg := "b01010000".U}  // R
        is(9.U) {sevSeg := "b00111000".U}  // L
        is(10.U) {sevSeg := "b01011110".U} // D
        is(11.U) {sevSeg := "b00000000".U} // 
        is(12.U) {sevSeg := "b10000000".U} // .
        is(13.U) {sevSeg := "b00000000".U} // 
        is(14.U) {sevSeg := "b10000000".U} // .
        is(15.U) {sevSeg := "b00000000".U} //  
      }
    }

    ///////////////////
    // MODE 4 - DICE //
    ///////////////////
    is(4.U) {
      switch(diceReg) {
        is(0.U) { sevSeg := "b00111111".U }
        is(1.U) { sevSeg := "b00000110".U }
        is(2.U) { sevSeg := "b01011011".U }
        is(3.U) { sevSeg := "b01001111".U }
        is(4.U) { sevSeg := "b01100110".U }
        is(5.U) { sevSeg := "b01101101".U }
        is(6.U) { sevSeg := "b01111101".U }
      }
    }

    //////////////////////////////
    // MODE 5 - SIMON SAYS //
    //////////////////////////////
    is(5.U) {
      
    }

    ////////////////////////////
    // MODE 6 - PULSING LIGHT //
    ////////////////////////////
    is(6.U) {
      when (cntReg === 2500000.U) { 
        when (changeDirection) {
          brightness := brightness + 1.U
          when (brightness === 14.U) { changeDirection := false.B }
        } 
        .otherwise {
          brightness := brightness - 1.U
          when (brightness === 1.U) { changeDirection := true.B }
        }
      }
      sevSeg := Mux(ledStatus, "b11111111".U, "b00000000".U)
    }

    /////////////////////////////
    // MODE 7 - HAMMING WEIGHT //
    /////////////////////////////
    is(7.U) {
      val hammingWeight = PopCount(io.ui_in) - 1.U
      switch(hammingWeight) {
        is(0.U) { sevSeg := "b00111111".U }
        is(1.U) { sevSeg := "b00000110".U }
        is(2.U) { sevSeg := "b01011011".U }
        is(3.U) { sevSeg := "b01001111".U }
        is(4.U) { sevSeg := "b01100110".U }
        is(5.U) { sevSeg := "b01101101".U }
        is(6.U) { sevSeg := "b01111101".U }
        is(7.U) { sevSeg := "b00000111".U }
      }
    }
  }
when(years === 100.U) {
  io.uio_out := 1.U  // For placing LED in, so it lights up after 100 years
}

io.uo_out := sevSeg

}

object ChiselTop extends App {
  emitVerilog(new ChiselTop(), Array("--target-dir", "src"))
}