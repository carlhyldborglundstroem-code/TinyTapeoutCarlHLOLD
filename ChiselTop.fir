circuit ChiselTop :
  module ChiselTop :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip ui_in : UInt<8>, uo_out : UInt<8>, flip uio_in : UInt<8>, uio_out : UInt<8>, uio_oe : UInt<8>}

    io.uio_out <= UInt<1>("h0") @[ChiselTop.scala 17:14]
    io.uio_oe <= UInt<8>("hff") @[ChiselTop.scala 18:14]
    wire mode : UInt<3> @[ChiselTop.scala 23:28]
    mode <= UInt<3>("h0") @[ChiselTop.scala 23:28]
    reg fast : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[ChiselTop.scala 24:24]
    reg medium : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[ChiselTop.scala 25:24]
    reg slow : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[ChiselTop.scala 26:24]
    reg tick2hz : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[ChiselTop.scala 27:24]
    reg tick1hz : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[ChiselTop.scala 28:24]
    reg cntReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ChiselTop.scala 29:24]
    wire sevSeg : UInt<8> @[ChiselTop.scala 30:28]
    sevSeg <= UInt<8>("hff") @[ChiselTop.scala 30:28]
    reg diceReg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h1")) @[ChiselTop.scala 31:24]
    reg seconds : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[ChiselTop.scala 33:26]
    reg minutes : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[ChiselTop.scala 34:26]
    reg hours : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ChiselTop.scala 35:26]
    reg days : UInt<9>, clock with :
      reset => (reset, UInt<9>("h0")) @[ChiselTop.scala 36:26]
    reg years : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[ChiselTop.scala 37:26]
    reg pwmCount : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[ChiselTop.scala 39:32]
    reg brightness : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[ChiselTop.scala 40:32]
    reg changeDirection : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[ChiselTop.scala 41:32]
    node ledStatus = lt(pwmCount, brightness) @[ChiselTop.scala 42:28]
    node _T = bits(io.ui_in, 7, 7) @[ChiselTop.scala 47:16]
    when _T : @[ChiselTop.scala 47:21]
      mode <= UInt<3>("h7") @[ChiselTop.scala 48:10]
    else :
      node _T_1 = bits(io.ui_in, 6, 6) @[ChiselTop.scala 49:23]
      when _T_1 : @[ChiselTop.scala 49:28]
        mode <= UInt<3>("h6") @[ChiselTop.scala 50:10]
      else :
        node _T_2 = bits(io.ui_in, 5, 5) @[ChiselTop.scala 51:23]
        when _T_2 : @[ChiselTop.scala 51:28]
          mode <= UInt<3>("h5") @[ChiselTop.scala 52:10]
        else :
          node _T_3 = bits(io.ui_in, 4, 4) @[ChiselTop.scala 53:23]
          when _T_3 : @[ChiselTop.scala 53:28]
            mode <= UInt<3>("h4") @[ChiselTop.scala 54:10]
          else :
            node _T_4 = bits(io.ui_in, 3, 3) @[ChiselTop.scala 55:23]
            when _T_4 : @[ChiselTop.scala 55:28]
              mode <= UInt<2>("h3") @[ChiselTop.scala 56:10]
            else :
              node _T_5 = bits(io.ui_in, 2, 2) @[ChiselTop.scala 57:23]
              when _T_5 : @[ChiselTop.scala 57:28]
                mode <= UInt<2>("h2") @[ChiselTop.scala 58:10]
              else :
                node _T_6 = bits(io.ui_in, 1, 1) @[ChiselTop.scala 59:23]
                when _T_6 : @[ChiselTop.scala 59:28]
                  mode <= UInt<1>("h1") @[ChiselTop.scala 60:10]
                else :
                  node _T_7 = bits(io.ui_in, 0, 0) @[ChiselTop.scala 61:23]
                  when _T_7 : @[ChiselTop.scala 61:28]
                    mode <= UInt<1>("h0") @[ChiselTop.scala 62:10]
    node _cntReg_T = add(cntReg, UInt<1>("h1")) @[ChiselTop.scala 68:20]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[ChiselTop.scala 68:20]
    cntReg <= _cntReg_T_1 @[ChiselTop.scala 68:10]
    node _diceReg_T = add(diceReg, UInt<1>("h1")) @[ChiselTop.scala 69:22]
    node _diceReg_T_1 = tail(_diceReg_T, 1) @[ChiselTop.scala 69:22]
    diceReg <= _diceReg_T_1 @[ChiselTop.scala 69:11]
    node _T_8 = eq(diceReg, UInt<3>("h7")) @[ChiselTop.scala 70:17]
    when _T_8 : @[ChiselTop.scala 70:26]
      diceReg <= UInt<1>("h1") @[ChiselTop.scala 71:13]
    node _pwmCount_T = add(pwmCount, UInt<1>("h1")) @[ChiselTop.scala 73:24]
    node _pwmCount_T_1 = tail(_pwmCount_T, 1) @[ChiselTop.scala 73:24]
    pwmCount <= _pwmCount_T_1 @[ChiselTop.scala 73:12]
    node _T_9 = eq(cntReg, UInt<22>("h2625a0")) @[ChiselTop.scala 75:16]
    when _T_9 : @[ChiselTop.scala 75:31]
      cntReg <= UInt<1>("h0") @[ChiselTop.scala 76:12]
      node _fast_T = add(fast, UInt<1>("h1")) @[ChiselTop.scala 77:18]
      node _fast_T_1 = tail(_fast_T, 1) @[ChiselTop.scala 77:18]
      fast <= _fast_T_1 @[ChiselTop.scala 77:10]
      node _T_10 = eq(fast, UInt<3>("h7")) @[ChiselTop.scala 78:16]
      when _T_10 : @[ChiselTop.scala 78:25]
        fast <= UInt<1>("h0") @[ChiselTop.scala 79:12]
      node _tick2hz_T = add(tick2hz, UInt<1>("h1")) @[ChiselTop.scala 81:24]
      node _tick2hz_T_1 = tail(_tick2hz_T, 1) @[ChiselTop.scala 81:24]
      tick2hz <= _tick2hz_T_1 @[ChiselTop.scala 81:13]
      node _T_11 = eq(tick2hz, UInt<3>("h4")) @[ChiselTop.scala 82:19]
      when _T_11 : @[ChiselTop.scala 82:28]
        tick2hz <= UInt<1>("h0") @[ChiselTop.scala 83:15]
        node _medium_T = add(medium, UInt<1>("h1")) @[ChiselTop.scala 84:24]
        node _medium_T_1 = tail(_medium_T, 1) @[ChiselTop.scala 84:24]
        medium <= _medium_T_1 @[ChiselTop.scala 84:14]
        node _T_12 = eq(medium, UInt<4>("hf")) @[ChiselTop.scala 85:20]
        when _T_12 : @[ChiselTop.scala 85:30]
          medium <= UInt<1>("h0") @[ChiselTop.scala 86:16]
        node _tick1hz_T = add(tick1hz, UInt<1>("h1")) @[ChiselTop.scala 89:26]
        node _tick1hz_T_1 = tail(_tick1hz_T, 1) @[ChiselTop.scala 89:26]
        tick1hz <= _tick1hz_T_1 @[ChiselTop.scala 89:15]
        node _T_13 = eq(tick1hz, UInt<1>("h1")) @[ChiselTop.scala 90:21]
        when _T_13 : @[ChiselTop.scala 90:30]
          tick1hz <= UInt<1>("h0") @[ChiselTop.scala 91:17]
          node _slow_T = add(slow, UInt<1>("h1")) @[ChiselTop.scala 92:22]
          node _slow_T_1 = tail(_slow_T, 1) @[ChiselTop.scala 92:22]
          slow <= _slow_T_1 @[ChiselTop.scala 92:14]
          node _T_14 = eq(slow, UInt<4>("h9")) @[ChiselTop.scala 93:20]
          when _T_14 : @[ChiselTop.scala 93:29]
            slow <= UInt<1>("h0") @[ChiselTop.scala 94:16]
          node _seconds_T = add(seconds, UInt<1>("h1")) @[ChiselTop.scala 96:28]
          node _seconds_T_1 = tail(_seconds_T, 1) @[ChiselTop.scala 96:28]
          seconds <= _seconds_T_1 @[ChiselTop.scala 96:17]
          node _T_15 = eq(seconds, UInt<6>("h3b")) @[ChiselTop.scala 97:23]
          when _T_15 : @[ChiselTop.scala 97:33]
            seconds <= UInt<1>("h0") @[ChiselTop.scala 98:19]
            node _minutes_T = add(minutes, UInt<1>("h1")) @[ChiselTop.scala 99:30]
            node _minutes_T_1 = tail(_minutes_T, 1) @[ChiselTop.scala 99:30]
            minutes <= _minutes_T_1 @[ChiselTop.scala 99:19]
            node _T_16 = eq(minutes, UInt<6>("h3b")) @[ChiselTop.scala 100:25]
            when _T_16 : @[ChiselTop.scala 100:35]
              minutes <= UInt<1>("h0") @[ChiselTop.scala 101:21]
              node _hours_T = add(hours, UInt<1>("h1")) @[ChiselTop.scala 102:28]
              node _hours_T_1 = tail(_hours_T, 1) @[ChiselTop.scala 102:28]
              hours <= _hours_T_1 @[ChiselTop.scala 102:19]
              node _T_17 = eq(hours, UInt<5>("h17")) @[ChiselTop.scala 103:25]
              when _T_17 : @[ChiselTop.scala 103:35]
                hours <= UInt<1>("h0") @[ChiselTop.scala 104:21]
                node _days_T = add(days, UInt<1>("h1")) @[ChiselTop.scala 105:28]
                node _days_T_1 = tail(_days_T, 1) @[ChiselTop.scala 105:28]
                days <= _days_T_1 @[ChiselTop.scala 105:20]
                node _T_18 = eq(days, UInt<9>("h16c")) @[ChiselTop.scala 106:26]
                when _T_18 : @[ChiselTop.scala 106:37]
                  days <= UInt<1>("h0") @[ChiselTop.scala 107:22]
                  node _years_T = add(years, UInt<1>("h1")) @[ChiselTop.scala 108:32]
                  node _years_T_1 = tail(_years_T, 1) @[ChiselTop.scala 108:32]
                  years <= _years_T_1 @[ChiselTop.scala 108:23]
    node _T_19 = eq(UInt<1>("h0"), mode) @[ChiselTop.scala 120:16]
    when _T_19 : @[ChiselTop.scala 120:16]
      node _T_20 = eq(UInt<1>("h0"), fast) @[ChiselTop.scala 126:20]
      when _T_20 : @[ChiselTop.scala 126:20]
        sevSeg <= UInt<1>("h1") @[ChiselTop.scala 127:25]
      else :
        node _T_21 = eq(UInt<1>("h1"), fast) @[ChiselTop.scala 126:20]
        when _T_21 : @[ChiselTop.scala 126:20]
          sevSeg <= UInt<2>("h2") @[ChiselTop.scala 128:25]
        else :
          node _T_22 = eq(UInt<2>("h2"), fast) @[ChiselTop.scala 126:20]
          when _T_22 : @[ChiselTop.scala 126:20]
            sevSeg <= UInt<3>("h4") @[ChiselTop.scala 129:25]
          else :
            node _T_23 = eq(UInt<2>("h3"), fast) @[ChiselTop.scala 126:20]
            when _T_23 : @[ChiselTop.scala 126:20]
              sevSeg <= UInt<4>("h8") @[ChiselTop.scala 130:25]
            else :
              node _T_24 = eq(UInt<3>("h4"), fast) @[ChiselTop.scala 126:20]
              when _T_24 : @[ChiselTop.scala 126:20]
                sevSeg <= UInt<5>("h10") @[ChiselTop.scala 131:25]
              else :
                node _T_25 = eq(UInt<3>("h5"), fast) @[ChiselTop.scala 126:20]
                when _T_25 : @[ChiselTop.scala 126:20]
                  sevSeg <= UInt<6>("h20") @[ChiselTop.scala 132:25]
                else :
                  node _T_26 = eq(UInt<3>("h6"), fast) @[ChiselTop.scala 126:20]
                  when _T_26 : @[ChiselTop.scala 126:20]
                    sevSeg <= UInt<7>("h40") @[ChiselTop.scala 133:25]
    else :
      node _T_27 = eq(UInt<1>("h1"), mode) @[ChiselTop.scala 120:16]
      when _T_27 : @[ChiselTop.scala 120:16]
        node _T_28 = eq(UInt<3>("h6"), fast) @[ChiselTop.scala 141:20]
        when _T_28 : @[ChiselTop.scala 141:20]
          sevSeg <= UInt<1>("h1") @[ChiselTop.scala 142:25]
        else :
          node _T_29 = eq(UInt<3>("h5"), fast) @[ChiselTop.scala 141:20]
          when _T_29 : @[ChiselTop.scala 141:20]
            sevSeg <= UInt<2>("h2") @[ChiselTop.scala 143:25]
          else :
            node _T_30 = eq(UInt<3>("h4"), fast) @[ChiselTop.scala 141:20]
            when _T_30 : @[ChiselTop.scala 141:20]
              sevSeg <= UInt<3>("h4") @[ChiselTop.scala 144:25]
            else :
              node _T_31 = eq(UInt<2>("h3"), fast) @[ChiselTop.scala 141:20]
              when _T_31 : @[ChiselTop.scala 141:20]
                sevSeg <= UInt<4>("h8") @[ChiselTop.scala 145:25]
              else :
                node _T_32 = eq(UInt<2>("h2"), fast) @[ChiselTop.scala 141:20]
                when _T_32 : @[ChiselTop.scala 141:20]
                  sevSeg <= UInt<5>("h10") @[ChiselTop.scala 146:25]
                else :
                  node _T_33 = eq(UInt<1>("h1"), fast) @[ChiselTop.scala 141:20]
                  when _T_33 : @[ChiselTop.scala 141:20]
                    sevSeg <= UInt<6>("h20") @[ChiselTop.scala 147:25]
                  else :
                    node _T_34 = eq(UInt<1>("h0"), fast) @[ChiselTop.scala 141:20]
                    when _T_34 : @[ChiselTop.scala 141:20]
                      sevSeg <= UInt<7>("h40") @[ChiselTop.scala 148:25]
      else :
        node _T_35 = eq(UInt<2>("h2"), mode) @[ChiselTop.scala 120:16]
        when _T_35 : @[ChiselTop.scala 120:16]
          node _T_36 = eq(UInt<1>("h0"), slow) @[ChiselTop.scala 156:20]
          when _T_36 : @[ChiselTop.scala 156:20]
            sevSeg <= UInt<6>("h3f") @[ChiselTop.scala 157:25]
          else :
            node _T_37 = eq(UInt<1>("h1"), slow) @[ChiselTop.scala 156:20]
            when _T_37 : @[ChiselTop.scala 156:20]
              sevSeg <= UInt<3>("h6") @[ChiselTop.scala 158:25]
            else :
              node _T_38 = eq(UInt<2>("h2"), slow) @[ChiselTop.scala 156:20]
              when _T_38 : @[ChiselTop.scala 156:20]
                sevSeg <= UInt<7>("h5b") @[ChiselTop.scala 159:25]
              else :
                node _T_39 = eq(UInt<2>("h3"), slow) @[ChiselTop.scala 156:20]
                when _T_39 : @[ChiselTop.scala 156:20]
                  sevSeg <= UInt<7>("h4f") @[ChiselTop.scala 160:25]
                else :
                  node _T_40 = eq(UInt<3>("h4"), slow) @[ChiselTop.scala 156:20]
                  when _T_40 : @[ChiselTop.scala 156:20]
                    sevSeg <= UInt<7>("h66") @[ChiselTop.scala 161:25]
                  else :
                    node _T_41 = eq(UInt<3>("h5"), slow) @[ChiselTop.scala 156:20]
                    when _T_41 : @[ChiselTop.scala 156:20]
                      sevSeg <= UInt<7>("h6d") @[ChiselTop.scala 162:25]
                    else :
                      node _T_42 = eq(UInt<3>("h6"), slow) @[ChiselTop.scala 156:20]
                      when _T_42 : @[ChiselTop.scala 156:20]
                        sevSeg <= UInt<7>("h7d") @[ChiselTop.scala 163:25]
                      else :
                        node _T_43 = eq(UInt<3>("h7"), slow) @[ChiselTop.scala 156:20]
                        when _T_43 : @[ChiselTop.scala 156:20]
                          sevSeg <= UInt<3>("h7") @[ChiselTop.scala 164:25]
                        else :
                          node _T_44 = eq(UInt<4>("h8"), slow) @[ChiselTop.scala 156:20]
                          when _T_44 : @[ChiselTop.scala 156:20]
                            sevSeg <= UInt<7>("h7f") @[ChiselTop.scala 165:25]
                          else :
                            node _T_45 = eq(UInt<4>("h9"), slow) @[ChiselTop.scala 156:20]
                            when _T_45 : @[ChiselTop.scala 156:20]
                              sevSeg <= UInt<7>("h6f") @[ChiselTop.scala 166:25]
        else :
          node _T_46 = eq(UInt<2>("h3"), mode) @[ChiselTop.scala 120:16]
          when _T_46 : @[ChiselTop.scala 120:16]
            node _T_47 = eq(UInt<1>("h0"), medium) @[ChiselTop.scala 174:22]
            when _T_47 : @[ChiselTop.scala 174:22]
              sevSeg <= UInt<7>("h76") @[ChiselTop.scala 175:25]
            else :
              node _T_48 = eq(UInt<1>("h1"), medium) @[ChiselTop.scala 174:22]
              when _T_48 : @[ChiselTop.scala 174:22]
                sevSeg <= UInt<7>("h79") @[ChiselTop.scala 176:25]
              else :
                node _T_49 = eq(UInt<2>("h2"), medium) @[ChiselTop.scala 174:22]
                when _T_49 : @[ChiselTop.scala 174:22]
                  sevSeg <= UInt<6>("h38") @[ChiselTop.scala 177:25]
                else :
                  node _T_50 = eq(UInt<2>("h3"), medium) @[ChiselTop.scala 174:22]
                  when _T_50 : @[ChiselTop.scala 174:22]
                    sevSeg <= UInt<6>("h38") @[ChiselTop.scala 178:25]
                  else :
                    node _T_51 = eq(UInt<3>("h4"), medium) @[ChiselTop.scala 174:22]
                    when _T_51 : @[ChiselTop.scala 174:22]
                      sevSeg <= UInt<6>("h3f") @[ChiselTop.scala 179:25]
                    else :
                      node _T_52 = eq(UInt<3>("h5"), medium) @[ChiselTop.scala 174:22]
                      when _T_52 : @[ChiselTop.scala 174:22]
                        sevSeg <= UInt<1>("h0") @[ChiselTop.scala 180:25]
                      else :
                        node _T_53 = eq(UInt<3>("h6"), medium) @[ChiselTop.scala 174:22]
                        when _T_53 : @[ChiselTop.scala 174:22]
                          sevSeg <= UInt<7>("h6a") @[ChiselTop.scala 181:25]
                        else :
                          node _T_54 = eq(UInt<3>("h7"), medium) @[ChiselTop.scala 174:22]
                          when _T_54 : @[ChiselTop.scala 174:22]
                            sevSeg <= UInt<6>("h3f") @[ChiselTop.scala 182:25]
                          else :
                            node _T_55 = eq(UInt<4>("h8"), medium) @[ChiselTop.scala 174:22]
                            when _T_55 : @[ChiselTop.scala 174:22]
                              sevSeg <= UInt<7>("h50") @[ChiselTop.scala 183:25]
                            else :
                              node _T_56 = eq(UInt<4>("h9"), medium) @[ChiselTop.scala 174:22]
                              when _T_56 : @[ChiselTop.scala 174:22]
                                sevSeg <= UInt<6>("h38") @[ChiselTop.scala 184:25]
                              else :
                                node _T_57 = eq(UInt<4>("ha"), medium) @[ChiselTop.scala 174:22]
                                when _T_57 : @[ChiselTop.scala 174:22]
                                  sevSeg <= UInt<7>("h5e") @[ChiselTop.scala 185:26]
                                else :
                                  node _T_58 = eq(UInt<4>("hb"), medium) @[ChiselTop.scala 174:22]
                                  when _T_58 : @[ChiselTop.scala 174:22]
                                    sevSeg <= UInt<1>("h0") @[ChiselTop.scala 186:26]
                                  else :
                                    node _T_59 = eq(UInt<4>("hc"), medium) @[ChiselTop.scala 174:22]
                                    when _T_59 : @[ChiselTop.scala 174:22]
                                      sevSeg <= UInt<8>("h80") @[ChiselTop.scala 187:26]
                                    else :
                                      node _T_60 = eq(UInt<4>("hd"), medium) @[ChiselTop.scala 174:22]
                                      when _T_60 : @[ChiselTop.scala 174:22]
                                        sevSeg <= UInt<1>("h0") @[ChiselTop.scala 188:26]
                                      else :
                                        node _T_61 = eq(UInt<4>("he"), medium) @[ChiselTop.scala 174:22]
                                        when _T_61 : @[ChiselTop.scala 174:22]
                                          sevSeg <= UInt<8>("h80") @[ChiselTop.scala 189:26]
                                        else :
                                          node _T_62 = eq(UInt<4>("hf"), medium) @[ChiselTop.scala 174:22]
                                          when _T_62 : @[ChiselTop.scala 174:22]
                                            sevSeg <= UInt<1>("h0") @[ChiselTop.scala 190:26]
          else :
            node _T_63 = eq(UInt<3>("h4"), mode) @[ChiselTop.scala 120:16]
            when _T_63 : @[ChiselTop.scala 120:16]
              node _T_64 = eq(UInt<1>("h0"), diceReg) @[ChiselTop.scala 198:23]
              when _T_64 : @[ChiselTop.scala 198:23]
                sevSeg <= UInt<6>("h3f") @[ChiselTop.scala 199:26]
              else :
                node _T_65 = eq(UInt<1>("h1"), diceReg) @[ChiselTop.scala 198:23]
                when _T_65 : @[ChiselTop.scala 198:23]
                  sevSeg <= UInt<3>("h6") @[ChiselTop.scala 200:26]
                else :
                  node _T_66 = eq(UInt<2>("h2"), diceReg) @[ChiselTop.scala 198:23]
                  when _T_66 : @[ChiselTop.scala 198:23]
                    sevSeg <= UInt<7>("h5b") @[ChiselTop.scala 201:26]
                  else :
                    node _T_67 = eq(UInt<2>("h3"), diceReg) @[ChiselTop.scala 198:23]
                    when _T_67 : @[ChiselTop.scala 198:23]
                      sevSeg <= UInt<7>("h4f") @[ChiselTop.scala 202:26]
                    else :
                      node _T_68 = eq(UInt<3>("h4"), diceReg) @[ChiselTop.scala 198:23]
                      when _T_68 : @[ChiselTop.scala 198:23]
                        sevSeg <= UInt<7>("h66") @[ChiselTop.scala 203:26]
                      else :
                        node _T_69 = eq(UInt<3>("h5"), diceReg) @[ChiselTop.scala 198:23]
                        when _T_69 : @[ChiselTop.scala 198:23]
                          sevSeg <= UInt<7>("h6d") @[ChiselTop.scala 204:26]
                        else :
                          node _T_70 = eq(UInt<3>("h6"), diceReg) @[ChiselTop.scala 198:23]
                          when _T_70 : @[ChiselTop.scala 198:23]
                            sevSeg <= UInt<7>("h7d") @[ChiselTop.scala 205:26]
            else :
              node _T_71 = eq(UInt<3>("h5"), mode) @[ChiselTop.scala 120:16]
              when _T_71 : @[ChiselTop.scala 120:16]
                skip
              else :
                node _T_72 = eq(UInt<3>("h6"), mode) @[ChiselTop.scala 120:16]
                when _T_72 : @[ChiselTop.scala 120:16]
                  node _T_73 = eq(cntReg, UInt<22>("h2625a0")) @[ChiselTop.scala 220:20]
                  when _T_73 : @[ChiselTop.scala 220:35]
                    when changeDirection : @[ChiselTop.scala 221:32]
                      node _brightness_T = add(brightness, UInt<1>("h1")) @[ChiselTop.scala 222:36]
                      node _brightness_T_1 = tail(_brightness_T, 1) @[ChiselTop.scala 222:36]
                      brightness <= _brightness_T_1 @[ChiselTop.scala 222:22]
                      node _T_74 = eq(brightness, UInt<4>("he")) @[ChiselTop.scala 223:28]
                      when _T_74 : @[ChiselTop.scala 223:38]
                        changeDirection <= UInt<1>("h0") @[ChiselTop.scala 223:56]
                    else :
                      node _brightness_T_2 = sub(brightness, UInt<1>("h1")) @[ChiselTop.scala 226:36]
                      node _brightness_T_3 = tail(_brightness_T_2, 1) @[ChiselTop.scala 226:36]
                      brightness <= _brightness_T_3 @[ChiselTop.scala 226:22]
                      node _T_75 = eq(brightness, UInt<1>("h1")) @[ChiselTop.scala 227:28]
                      when _T_75 : @[ChiselTop.scala 227:37]
                        changeDirection <= UInt<1>("h1") @[ChiselTop.scala 227:55]
                  node _sevSeg_T = mux(ledStatus, UInt<8>("hff"), UInt<1>("h0")) @[ChiselTop.scala 230:20]
                  sevSeg <= _sevSeg_T @[ChiselTop.scala 230:14]
                else :
                  node _T_76 = eq(UInt<3>("h7"), mode) @[ChiselTop.scala 120:16]
                  when _T_76 : @[ChiselTop.scala 120:16]
                    node _hammingWeight_T = bits(io.ui_in, 0, 0) @[Bitwise.scala 53:100]
                    node _hammingWeight_T_1 = bits(io.ui_in, 1, 1) @[Bitwise.scala 53:100]
                    node _hammingWeight_T_2 = bits(io.ui_in, 2, 2) @[Bitwise.scala 53:100]
                    node _hammingWeight_T_3 = bits(io.ui_in, 3, 3) @[Bitwise.scala 53:100]
                    node _hammingWeight_T_4 = bits(io.ui_in, 4, 4) @[Bitwise.scala 53:100]
                    node _hammingWeight_T_5 = bits(io.ui_in, 5, 5) @[Bitwise.scala 53:100]
                    node _hammingWeight_T_6 = bits(io.ui_in, 6, 6) @[Bitwise.scala 53:100]
                    node _hammingWeight_T_7 = bits(io.ui_in, 7, 7) @[Bitwise.scala 53:100]
                    node _hammingWeight_T_8 = add(_hammingWeight_T, _hammingWeight_T_1) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_9 = bits(_hammingWeight_T_8, 1, 0) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_10 = add(_hammingWeight_T_2, _hammingWeight_T_3) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_11 = bits(_hammingWeight_T_10, 1, 0) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_12 = add(_hammingWeight_T_9, _hammingWeight_T_11) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_13 = bits(_hammingWeight_T_12, 2, 0) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_14 = add(_hammingWeight_T_4, _hammingWeight_T_5) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_15 = bits(_hammingWeight_T_14, 1, 0) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_16 = add(_hammingWeight_T_6, _hammingWeight_T_7) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_17 = bits(_hammingWeight_T_16, 1, 0) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_18 = add(_hammingWeight_T_15, _hammingWeight_T_17) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_19 = bits(_hammingWeight_T_18, 2, 0) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_20 = add(_hammingWeight_T_13, _hammingWeight_T_19) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_21 = bits(_hammingWeight_T_20, 3, 0) @[Bitwise.scala 51:90]
                    node _hammingWeight_T_22 = sub(_hammingWeight_T_21, UInt<1>("h1")) @[ChiselTop.scala 237:46]
                    node hammingWeight = tail(_hammingWeight_T_22, 1) @[ChiselTop.scala 237:46]
                    node _T_77 = eq(UInt<1>("h0"), hammingWeight) @[ChiselTop.scala 238:29]
                    when _T_77 : @[ChiselTop.scala 238:29]
                      sevSeg <= UInt<6>("h3f") @[ChiselTop.scala 239:26]
                    else :
                      node _T_78 = eq(UInt<1>("h1"), hammingWeight) @[ChiselTop.scala 238:29]
                      when _T_78 : @[ChiselTop.scala 238:29]
                        sevSeg <= UInt<3>("h6") @[ChiselTop.scala 240:26]
                      else :
                        node _T_79 = eq(UInt<2>("h2"), hammingWeight) @[ChiselTop.scala 238:29]
                        when _T_79 : @[ChiselTop.scala 238:29]
                          sevSeg <= UInt<7>("h5b") @[ChiselTop.scala 241:26]
                        else :
                          node _T_80 = eq(UInt<2>("h3"), hammingWeight) @[ChiselTop.scala 238:29]
                          when _T_80 : @[ChiselTop.scala 238:29]
                            sevSeg <= UInt<7>("h4f") @[ChiselTop.scala 242:26]
                          else :
                            node _T_81 = eq(UInt<3>("h4"), hammingWeight) @[ChiselTop.scala 238:29]
                            when _T_81 : @[ChiselTop.scala 238:29]
                              sevSeg <= UInt<7>("h66") @[ChiselTop.scala 243:26]
                            else :
                              node _T_82 = eq(UInt<3>("h5"), hammingWeight) @[ChiselTop.scala 238:29]
                              when _T_82 : @[ChiselTop.scala 238:29]
                                sevSeg <= UInt<7>("h6d") @[ChiselTop.scala 244:26]
                              else :
                                node _T_83 = eq(UInt<3>("h6"), hammingWeight) @[ChiselTop.scala 238:29]
                                when _T_83 : @[ChiselTop.scala 238:29]
                                  sevSeg <= UInt<7>("h7d") @[ChiselTop.scala 245:26]
                                else :
                                  node _T_84 = eq(UInt<3>("h7"), hammingWeight) @[ChiselTop.scala 238:29]
                                  when _T_84 : @[ChiselTop.scala 238:29]
                                    sevSeg <= UInt<3>("h7") @[ChiselTop.scala 246:26]
    node _T_85 = eq(years, UInt<7>("h64")) @[ChiselTop.scala 250:12]
    when _T_85 : @[ChiselTop.scala 250:23]
      io.uio_out <= UInt<1>("h1") @[ChiselTop.scala 251:14]
    io.uo_out <= sevSeg @[ChiselTop.scala 254:11]

