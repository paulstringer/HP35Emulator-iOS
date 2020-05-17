// The Global Registers
var x; // 1st register (mapped onto the display)
var y; // 2nd register
var z; // 3rd register
var t; // 4th register
var s; // memory
var d; // display (text version of x)

// The Typing Mode
var mode = 0;
//-1 - Typing a digit will replace x, and be negative (CH S)
// 0 - Typing a digit will replace x
// 1 - Typing a digit will append to x
// 2 - Typing a digit will append to x after decimal
// 3 - Typing a digit will appear in the exponent

// The Arc Mode
var arc = 0;

// "The stack is automatically raised by an entry into x or by RCL
// unless the entry immediately follows CLx, STO or ENTER."
var auto_enter = 0;

function x2d() {
  // Convert the JavaScript number 'x' into the display digits for 'd', then display it.
  // e.g.  6 => ' 6.'
  // Sometimes has the side-effect of resetting 'x' to a legal value.
  var MaxFloat = 9.999999999 * Math.pow(10, 99);
  if (isNaN(x) || x == Number.NEGATIVE_INFINITY || x == Number.POSITIVE_INFINITY) {
    // "improper operations flash display"
    d = ' Xx';
    x = 0;
  } else if (x >= MaxFloat) {
    // posative overflow is written as maximum number
    d = ' 9.999999999 99';
    x = MaxFloat;
  } else if (-MaxFloat >= x) {
    // negative overflow is written as minimum number
    d = '-9.999999999 99';
    x = -MaxFloat;
  } else {
    // a valid number
    var ext = '';
    d = x;
    if (Math.abs(d) > 9999999999) {
      // switch to exponential notation
      ext = 0;
      while (Math.abs(d) >= 10) {
        ext++;
        d = d/10;
      }
      ext = ' '+ext;
    } else if (d != 0 && Math.abs(d) < .01) {
      // switch to exponential notation
      ext = 0;
      while (Math.abs(d) < 1) {
        ext++;
        d = d*10;
      }
      if (ext > 99) {
        // underflow is written as zero
        d = 0;
        ext = '';
        x = 0;
      } else if (ext > 9) {
        ext = '-' + ext;
      } else {
        ext = '-0' + ext;
      }
    }
    if (!ext) // Round away some rounding errors on simple numbers.
      d = Math.round(d*10000000000)/10000000000;
    if (x < 0)
      d = '-'+(-d);
    else
      d = ' '+d;
    if (d.indexOf('.') == -1)
      d = d + '.';
    if (d.length > 3 && d.charAt(1) == '0' && d.charAt(2) == '.')
      d = d.charAt(0) + d.substring(2);
    d = (d+"               ").substring(0, 12)+ext;
  }
  // Display the result.
  display();
}

function d2x() {
  // Convert the display digits for 'd' into the JavaScript number 'x'.
  // e.g.  ' 06.0' => 6
  x = parseFloat((d+"               ").substring(0, 12));
  if (isNaN(x)) x = 0;

  var ext = (d+"               ").substring(12, 15);
  ext = parseInt(ext, 10);

  if (!isNaN(ext))
    x = x * Math.pow(10, ext);
}

function key_clx() {
  x = 0;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 0;
}

function key_clr() {
  y = 0;
  z = 0;
  t = 0;
  s = 0;
  key_clx();
}

function key_enter() {
  d2x();
  t=z;
  z=y;
  y=x;
  mode = 0;
  arc = 0;
  auto_enter = 0;
}

function key_r() {
  d2x();
  temp = x;
  x = y;
  y = z;
  z = t;
  t = temp
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_xy() {
  d2x();
  temp = x;
  x = y;
  y = temp;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_sto() {
  d2x();
  s = x;
  mode = 0;
  arc = 0;
  auto_enter = 0;
}

function key_rcl() {
  if (auto_enter) key_enter();
  x = s;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_pi() {
  if (auto_enter) key_enter();
  x = 3.141592654;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_add() {
  d2x();
  x = y + x;
  y = z;
  z = t;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_subtract() {
  d2x();
  x = y - x;
  y = z;
  z = t;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_multiply() {
  d2x();
  x = y * x;
  y = z;
  z = t;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_divide() {
  d2x();
  x = y / x;
  y = z;
  z = t;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_sqrt() {
  d2x();
  x = Math.sqrt(x);
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_pow() {
  d2x();
  x = Math.pow(x, y);
  y = z;
  z = t;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_epow() {
  d2x();
  x = Math.pow(Math.E, x);
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_ln() {
  d2x();
  x = Math.log(x);
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_log() {
  d2x();
  x = Math.LOG10E * Math.log(x);
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_inv() {
  d2x();
  x = 1/x;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_arc() {
  arc = 1;
  auto_enter = 1;
}

function key_sin() {
  d2x();
  if (arc == 1) {
    angle = Math.asin(x);
    x = angle * 180 / Math.PI;
  } else {
    angle = Math.PI / 180 * x;
    x = Math.sin(angle);
  }
  t = z;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_cos() {
  d2x();
  if (arc == 1) {
    angle = Math.acos(x);
    x = angle * 180 / Math.PI;
  } else {
    angle = Math.PI / 180 * x;
    x = Math.cos(angle);
  }
  t = z;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_tan() {
  d2x();
  if (arc == 1) {
    angle = Math.atan(x);
    x = angle * 180 / Math.PI;
  } else {
    angle = Math.PI / 180 * x;
    x = Math.tan(angle);
  }
  t = z;
  x2d();
  mode = 0;
  arc = 0;
  auto_enter = 1;
}

function key_eex() {
  d2x();
  if (x == 0)
    key_num(1);
  // 'EEX' automatically presses '1' for you if the display equals zero.
  mode = 3;
  arc = 0;
  auto_enter = 1;
}

function key_chs() {
  if (mode == 3) {
    // Exponential mode
    if ((d+"               ").substring(12, 15) == "   ") {
      // Only works if exponent is empty.
      d = (d+"               ").substring(0, 12)+"-00";
      display();
    }
  } else {
    // Integer and decimal modes
    if (d.charAt(0) == "-")
      d = " "+d.substring(1);
    else
      d = "-"+d.substring(1);
    display();
    if (mode == 0) // New number mode
      mode = -1; // HP-35 has a very broken CHS implementation
  }
  arc = 0;
}

function key_decimal() {
  if (mode == 4) {
    // The decimal key == the 0 key in exponent mode.  Interesting.
    key_num(0);
  } else {
    if (mode == -1) {
      x2d(); // restore old number (prior to CH S)
      if (auto_enter) key_enter();
      d = '-.';
      x = 0;
    } else if (mode == 0) {
      if (auto_enter) key_enter();
      d = ' .';
      x = 0;
    }
    display();
    mode = 2;
    arc = 0;
  }
}

function key_num(num) {
  if (mode == 3) {
    // Exponential mode
    var exp = (d+"                ").charAt(14);
    if (exp == " ") exp = '0';
    d = (d+"                ").substring(0, 13)+exp+num;
  } else if (mode == -1) {
    x2d(); // restore old number (prior to CH S)
    if (auto_enter) key_enter();
    d = '-'+num+'.';
    mode = 1;
  } else if (mode == 0) {
    if (auto_enter) key_enter();
    d = ' '+num+'.';
    mode = 1;
  } else if (d.length >= 12) {
    return; // Too many digits.
  } else if (mode == 1) {
    // Integer mode
    dec = d.indexOf('.');
    d = d.substring(0, dec) + num + '.';
  } else if (mode == 2) {
    // Decimal mode
    d = d + num;
  }
  display();
  d2x();
  arc = 0;
}
