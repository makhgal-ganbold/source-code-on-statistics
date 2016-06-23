#
# Signal
# Author: galaa
# Created on 2016/06/23 11:17:00
#

# Бодлого
# Хугацааны $[0,T]$ интервал дахь санамсаргүй $u$ эгшинд $\Delta$ урттай дохио илгээгдэнэ. Хүлээн авагч хугацааны $v\in[0,T]$ эгшнээс эхлэн $t$ хугацаагаар ажиллана. $T=1$, $\Delta=0.01$, $t=0.25$ нөхцөлд дохиог хүлээн авагч барьж авах магадлалыг үнэл.

set.seed(11); delta = 0.1; t = 0.25; catched = 0;

catch = function () {
  u = runif(n = 1); v = runif(n = 1);
  if (u + delta >= v && u <= v + t) return(1) else return(0);
}

for (i in 1:1000) {
  catched = catched + catch();
}

print(catched / 1000);
