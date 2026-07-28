// Analysis I — Cheat Sheet
// Reproduced in Typst (styling after the original LaTeX sheet by dcamenisch).

#let pml = 0.7cm    // left/right margin
#let pmt = 0.7cm    // top margin
#let pmb = 0.95cm   // bottom margin
#let pgut = 0.5cm   // column gutter

#set page(
  paper: "a4",
  flipped: true,
  margin: (x: pml, top: pmt, bottom: pmb),
  columns: 3,
  footer: context align(right, text(size: 7pt)[
    #counter(page).get().first() / #counter(page).final().first()
  ]),
  // Vertical rules between the three columns (centred in each gutter)
  background: {
    let w = (29.7cm - 2 * pml - 2 * pgut) / 3
    let h = 21cm - pmt - pmb
    let rule(dx) = place(top + left, dx: dx, dy: pmt, line(end: (0pt, h), stroke: 0.4pt + rgb("#999")))
    rule(pml + w + 0.5 * pgut)
    rule(pml + 2 * w + 1.5 * pgut)
  },
)
#set text(size: 8.4pt, font: "New Computer Modern", lang: "de")
#set par(justify: true, leading: 0.6em, spacing: 0.85em)
#set columns(gutter: pgut)
#show math.equation: set text(size: 8.4pt)
#set math.equation(numbering: none)
#set list(spacing: 0.85em)
#set enum(spacing: 0.85em, numbering: "i)")
#show math.equation.where(block: true): set block(above: 0.7em, below: 0.7em)

// ---- Styling helpers -------------------------------------------------------

// Yellow-highlighted top-level chapter header
#let chapter(title) = block(
  width: 100%,
  breakable: false,
  above: 1.1em,
  below: 0.7em,
  fill: rgb("#fff34d"),
  inset: (x: 3pt, y: 3pt),
  text(size: 13pt, weight: "bold", title),
)

// Black bar sub-section header (white text)
#let sub(title) = block(
  width: 100%,
  breakable: false,
  above: 1em,
  below: 0.6em,
  fill: black,
  inset: (x: 3pt, y: 2.6pt),
  text(fill: white, weight: "bold", size: 8.6pt, title),
)

// Green bar "Strategie" header
#let strat(title) = block(
  width: 100%,
  breakable: false,
  above: 1em,
  below: 0.6em,
  fill: rgb("#3fd35a"),
  inset: (x: 3pt, y: 2.6pt),
  text(fill: black, weight: "bold", size: 8.2pt, title),
)

// Rounded theorem / definition box
#let bx(body) = block(
  width: 100%,
  breakable: false,
  above: 0.7em,
  below: 0.7em,
  stroke: 0.5pt + rgb("#444"),
  radius: 2.5pt,
  inset: 5.5pt,
  body,
)

// Inner grid lines only — no surrounding rectangle (like the original LaTeX tables)
#let innergrid = (x, y) => (
  left: if x == 0 { 0pt } else { 0.4pt },
  top: if y == 0 { 0pt } else { 0.4pt },
  right: 0pt,
  bottom: 0pt,
)

#let D = $bold("Def.")$
#let S = $bold("Satz.")$
#let B = $bold("Bem.")$
#let K = $bold("Kor.")$

// List conventions:
//   +  enum → roman (i, ii, …): enumerated properties / conditions / cases (default)
//   #steps[ + … ] → arabic (1., 2., …): sequential step-by-step procedures
//   -  list → bullets: independent options / approaches (e.g. strategy checklists)
#let steps(body) = {
  set enum(numbering: "1.")
  body
}

// ---------------------------------------------------------------------------

#block(width: 100%, below: 0.7em, align(
  center,
  text(size: 17pt)[Analysis I] + linebreak() + text(size: 8pt, style: "italic")[T. Ruser],
))

#chapter[Reelle und komplexe Zahlen]

#sub[Axiome der Reelle Zahlen]
$RR$ ist ein komm., angeordneter Körper, der ordnungsvollständig ist.

*(A) Axiome der Addition* $quad x,y in RR ==> x+y in RR$
- *(A1)* Assoziativität: $x+(y+z)=(x+y)+z$
- *(A2)* Neutrales Element: $x+0=x$
- *(A3)* Inverses Element: $forall x in RR med exists y in RR: x+y=0$
- *(A4)* Kommutativität: $x+y=y+x$

*(M) Axiome der Multiplikation*
- *(M1)* Assoziativität: $x dot (y dot z)=(x dot y) dot z$
- *(M2)* Neutrales Element: $x dot 1 = x$
- *(M3)* Inverses Element: $forall x in RR, x eq.not 0 med exists y: x dot y = 1$
- *(M4)* Kommutativität: $x dot y = y dot x$

*(D) Axiom der Distributivität* $quad x dot (y+z)=x dot y + x dot z$

*(O) Ordnungsaxiome* (1–3: Partialorder)
- *(O1)* Reflexivität: $x <= x med forall x in RR$
- *(O2)* Transitivität: $x<=y and y<=z ==> x<=z$
- *(O3)* Antisymmetrie: $x<=y and y<=x ==> x=y$
- *(O4)* Total: $forall x,y$ gilt $y<=x$ oder $x<=y$

*(K) Kompatibilität*
- *(K1)* $forall x,y,z: x<=y ==> x+z<=y+z$
- *(K2)* $forall x>=0, forall y>=0: x dot y >= 0$

*(V) Ordnungsvollständigkeit* Seien $A,B subset.eq RR$ mit
+ $A eq.not emptyset, B eq.not emptyset$
+ $forall a in A, forall b in B: a<=b$

Dann $exists c in RR$ mit $a<=c<=b$.

#sub[Archimedisches Prinzip]
Sei $x in RR$ mit $x>0$ und $y in RR$. Dann gibt es $n in NN$ mit $n dot x > y$.

#K $forall epsilon>0 med exists n in NN: 0 < 1/n < epsilon$ (d.h. $1/n -> 0$).

$D quad |x| := max{x,-x}$
$ ==> |x y|=|x||y|, quad |x+y|<=|x|+|y|, quad |x+y|>=||x|-|y|| $
$ ||x|-|y|| <= |x-y| quad ("umgekehrte" triangle.stroked.small "-Ungl.") $
$triangle.stroked.small$-Ungleichung (auch für $CC$)

#sub[Supremum und Infimum]
#D $A subset.eq RR$ heisst von oben [unten] beschränkt (v.o.b. [v.u.b.]), falls es $x in RR$ gibt, sodass $x>=a$ [$x<=a$] für alle $a in A$. $x$ heisst dann obere [untere] Schranke.

$A$ beschränkt $:=$ v.o.b. und v.u.b.

Hat $A$ eine obere Schranke $x in A$, ist $x$ das Maximum, $x=max(A)$ (eindeutig). [Minimum analog]

#bx[
  #S Falls $A subset.eq RR, A eq.not emptyset$ v.o.b. [v.u.b.] ist, gibt es eine kleinste obere [grösste untere] Schranke $x$. $x$ heisst Supremum [Infimum], $x=sup(A)$ [$x=inf(A)$].
]

$x=sup(A)$ gilt g.d.w.:
+ $x>=a med forall a in A$
+ $forall y<x$ ist $y$ keine obere Schranke $<==> forall y<x med exists a in A$ mit $y<a$

Besitzt $A$ ein Maximum, ist $max(A)=sup(A)$.

$epsilon$-Form: $forall epsilon>0 med exists a in A: a > sup(A)-epsilon$ (analog Inf: $exists a in A: a < inf(A)+epsilon$).

*Eigenschaften*
+ $A subset.eq B subset.eq RR$, $B$ beschränkt $==> A$ beschränkt und $sup(A)<=sup(B), inf(A)>=inf(B)$
+ $A,B eq.not emptyset$, $a<=b med forall a in A, b in B ==> A$ v.o.b., $B$ v.u.b. und $sup(A)<=inf(B)$

Notation: $A$ nicht v.o.b. $=> sup(A)=oo$; nicht v.u.b. $=> inf(A)=-oo$.

$sup(emptyset)=-oo, inf(emptyset)=+oo$

#sub[Komplexe Zahlen — Definitionen]
#bx[
  #D Die *imaginäre Einheit* $i$ erfüllt $i^2=-1$. Komplexe Zahlen:
  $ z=x+i y, med x,y in RR; quad CC={x+i y : x,y in RR} $
]
Realteil $Re(z)=x$ ($x=0 =>$ rein imaginär); Imaginärteil $Im(z)=y$.

#sub[Betrag und Abstand]
*Betrag:* $|z|=|x+i y|=sqrt(x^2+y^2)>=0$

*Abstand:* $d=|z_1-z_2|=|z_2-z_1|$

Die $triangle$-Ungleichung gilt auch in $CC$.

#B *(Cauchy-Schwarz)* $x_1 x_2+y_1 y_2 <= |z_1| dot |z_2|$.

#sub[Komplexe Konjugation]
#D Die *Konjugierte* von $z=x+y i$ ist $overline(z)=x-y i$. Es gilt:
+ $z overline(z)=|z|^2$
+ $z+overline(z)=2Re(z)$, $quad z-overline(z)=2i Im(z)$
+ $overline(z plus.minus w)=overline(z) plus.minus overline(w)$, $quad overline(z w)=overline(z) dot overline(w)$, $quad overline((z/w))=overline(z)/overline(w)$
+ $z=overline(z) <==> z in RR$, $quad overline(z)=-z <==>$ rein imaginär
+ $sqrt(-a)=i sqrt(a)$ $(a>0)$

#sub[Eulersche Formel]
#bx[
  #S Für $t in RR$ gilt $e^(i t)=cos(t)+i sin(t)$, und damit
  $ cos(t)=(e^(i t)+e^(-i t))/2, quad sin(t)=(e^(i t)-e^(-i t))/(2i) $
]
+ $e^(i(t+2k pi))=e^(i t)$, $quad k in ZZ$
+ $overline(e^(i t))=e^(-i t)$
+ $e^(z+w)=e^z e^w$, $quad z,w in CC$
+ $e^z=e^(x+i y)=e^x(cos y + i sin y)$

#sub[Normal- und Polarform]
#D *Normalform (kartesisch):* $z=x+i y$.

*Trigonometrische Form:* $z=r(cos phi+i sin phi)$.

*Polarform (Exponentialform):* $z=r e^(i phi)$, mit $r=|z|>=0$ (Abstand zum Ursprung) und Polarwinkel $phi in (-pi,pi]$, $phi=arg(z)$.

*Umrechnung.* Polar $->$ Normal: $x=r cos phi, med y=r sin phi$. Normal $->$ Polar: $r=sqrt(x^2+y^2)$ und
$ phi=arctan(y/x) + cases(0 & x>0, +pi & x<0\, y>=0, -pi & x<0\, y<0) $
Für $x=0$: $arg=+pi/2$ ($y>0$), $-pi/2$ ($y<0$).

Alternativ $phi=plus.minus arccos(x/r)$.

#sub[Rechnen in Polarform]
+ $z_1 z_2 = r_1 r_2 e^(i(phi_1+phi_2))$
+ $z^k=r^k e^(i k phi)$
+ $z_1/z_2=(r_1)/(r_2) e^(i(phi_1-phi_2))$

#bx[
  #S *(Wurzeln)* $z^n=r e^(i phi)$ hat die $n$ Lösungen
  $ z_k=root(n, r) med e^(i(phi/n + k (2 pi)/n)), quad k=0,dots,n-1 $
]

#bx[#S *(Fundamentalsatz der Algebra)* Jedes nicht-konstante Polynom besitzt mindestens eine Nullstelle in $CC$.]

#chapter[Folgen und Reihen]

#sub[Definitionen]
#D Eine *Folge* (reeller Zahlen) ist eine Abbildung $a: NN_0 -> RR$. Wir schreiben $a_n$ statt $a(n)$ und bezeichnen sie mit $(a_n)_(n in NN_0)$. Bsp. $a_n=1/n$.

#D Sei $(a_n)_(n in NN_0)$ eine Folge in $RR$ oder $CC$, so ist die *Reihe* $(S_n)_(n in NN_0)$ die Partialsumme $S_n = sum_(k=1)^n a_k$.

#sub[Wichtige Folgen]
+ *Arithmetische Folge:* $(a_n)$ mit $a_(n+1)-a_n=d$ konstant, d.h. $a_n=a+(n-1)d$
+ *Geometrische Folge:* $(a_n)$ mit $a_(n+1)=q a_n$, d.h. $a_n=q^(n-1) dot a$

#S Es gilt
$ a+q a+dots+q^(n-1)a = cases(n a & "für " q=1, a dot (1-q^n)/(1-q) & "für " q eq.not 1) $

#sub[Grenzwert und Konvergenz]
#bx[
  #D Eine Folge $(a_n)_(n in NN_0)$ in $CC$ *konvergiert* für $n->oo$ gegen $L in CC$, falls
  $ forall epsilon>0 med exists N in NN: forall n>=N: |a_n - L|<epsilon. $
]
Äquivalent: $(a_n)$ konvergent, falls $exists L$ so dass $forall epsilon>0$ die Menge ${n: a_n in.not [L-epsilon, L+epsilon]}$ endlich ist.

$L=lim_(n->oo) a_n$ ist der Grenzwert.

Konvergiert $(S_n)$ gegen $S in CC$, so $S=sum_(n=1)^oo a_n$.

Konvergiert eine Folge/Reihe nicht, so *divergiert* sie.

Bsp.
+ $k in NN, a_n=n^k q^n, 0<=|q|<1 => lim a_n=0$
+ $c>=1, a_n=c^n/n! => lim a_n=0$
+ $b in ZZ, lim (1+1/n)^b=1$

#bx[#S Eine konvergente Folge ist immer beschränkt und hat *genau* einen Grenzwert.]
#B konvergent $==>$ beschränkt, aber nicht umgekehrt! ($(a_n)$ beschränkt $<==> exists M med forall n: |a_n|<=M$.)

$a_n$ konv. $==> b_n=a_(n+1)-a_n$ konv.

#B Konvergente Folge $==>$ jede Teilfolge konvergiert gegen denselben Grenzwert.

#S Ist $lim a_n = K < L = lim b_n$, so $exists N: a_n < b_n med forall n>=N$.

Um $a=lim a_n$ zu zeigen: forme $|a_n-a|<epsilon$ nach $n$ um (auf Ungleichzeichen & Wurzeln achten).

#bx[#S *(Sandwich)* Sei $lim a_n=alpha=lim c_n$ und $a_n<=b_n<=c_n med forall n>=k$. Dann $lim b_n=alpha$.]

#S Falls $(b_n)->0$ und $|a_n-a|<=b_n$, dann $(a_n)->a$.

#bx[
  #S Seien $a=lim a_n$, $b=lim b_n$ ($a,b eq.not plus.minus oo$). Dann:
  + $(a_n+b_n)->a+b$
  + $(a_n dot b_n)->a dot b$
  + Falls $b eq.not 0$: $a_n/b_n -> a/b$
  + Falls $exists K>=1: a_n<=b_n med forall n>=K$, so $a<=b$
]

#sub[Der Satz von Weierstrass]
#D $(a_n)$ *monoton wachsend* [fallend], falls $a_n<=a_(n+1)$ [$a_n>=a_(n+1)$], $forall n in NN_0$. (streng: $<$ [$>$])

#bx[
  #S $(a_n)$ monoton wachsend und nach oben beschränkt $==>$ konvergent mit $lim a_n = sup{a_n : n in NN_0}$. Analog fallend & nach unten beschränkt: $lim a_n = inf{a_n : n in NN_0}$.
]
#B Monotone Folge mit beschränkter Teilfolge $=>$ gesamte Folge konvergiert.

#sub[Bolzano Weierstrass]
#D Eine *Teilfolge* von $(a_n)$ ist $(b_n)$ mit $b_n=a_(l(n))$, $l: NN_0 -> NN_0$ mit $l(n)<l(n+1) med forall n$.

#bx[#S Jede beschränkte Folge besitzt eine konvergente Teilfolge.]

#D $A in RR$ ist *Häufungspunkt* von $(a_n)$, falls $forall epsilon>0 med forall N med exists n>=N: |a_n-A|<epsilon$ (jedes $(A-epsilon,A+epsilon)$ enthält unendlich viele Indizes). $<==>$ es existiert eine konvergente Teilfolge $(a_(n_k))$ mit $lim a_(n_k)=A$.

#sub[Limes Superior und Limes Inferior]
$ limsup_(n->oo) a_n = overline(lim)_(n->oo) a_n = lim_(n->oo) sup{a_k | k>=n} = inf_(n in NN)(sup{a_k | k>=n}) $
$ liminf_(n->oo) a_n = underline(lim)_(n->oo) a_n = lim_(n->oo) inf{a_k | k>=n} = sup_(n in NN)(inf{a_k | k>=n}) $
$(a_n)_(n in NN_0)$ konvergent $==> lim a_n = limsup a_n = liminf a_n$.

Beschränkte $(a_n)_(n in NN_0)$ konvergiert $==> lim_(n->oo) a_n = limsup_(n->oo) a_n = liminf_(n->oo) a_n$.

Sei $(a_n)_(n in NN_0)$ beschränkte Folge mit $A := limsup_(n->oo) a_n$. Dann ist $A$ Häufungspunkt und für alle $epsilon>0$ gilt:
+ nur endlich viele $a_n$ mit $a_n >= A+epsilon$
+ unendlich viele $a_n$ mit $A-epsilon < a_n < A+epsilon$

(analog für Limes Inf)

#bx[#S Jede beschränkte Folge aus $RR$ hat einen Häufungspunkt und eine konvergente Teilfolge.]

#D Ein *abgeschlossenes Intervall* hat die Form $[a,b], (-oo,b], [a,oo)$ oder $(-oo,oo)$. Länge $L(I)=b-a$.

#bx[
  #S *(Cauchy-Cantor)* Sei $I_1 supset.eq I_2 supset.eq dots$ eine Folge abgeschlossener Intervalle mit $L(I_1)<+oo$. Dann $inter.big_(n>=1) I_n eq.not emptyset$. Ist $lim L(I_n)=0$, enthält $inter.big I_n$ genau einen Punkt.
]

#sub[Konvergenzkriterien]
#B $(a_n)$ konvergent $<==>$ $(a_n)$ beschränkt und $liminf a_n = limsup a_n$.

#S $(a_n)$ monoton wachsend [fallend] konvergiert mit $lim a_n = sup_(n in NN_0)(a_n)$ [$inf$] g.d.w. $(a_n)$ beschränkt ist.

Folgen in $RR^d$ verhalten sich gleich: $(a_n)$ konvergiert falls $exists a in RR^d$ mit $forall epsilon>0 med exists N: ||a_n-a||<epsilon med forall n>=N$.

#sub[Das Cauchy-Kriterium]
#bx[
  #S $(a_n)$ ist genau dann konvergent, falls $forall epsilon>0 med exists N>=1$ so dass $|a_n-a_m|<epsilon med forall n,m>=N$. Solch eine Folge heisst *Cauchy-Folge*.
]
#B Für eine Cauchy-Folge:
+ $=>$ beschränkt
+ $<==>$ konvergent
$B quad a_n=sum_(i=1)^n 1/i$ konvergiert nicht, aber $|a_(n+1)-a_n| -> 0$.

#strat[Strategie – Konvergenz von Folgen]
- Brüche: grösste Potenz von $n$ ausklammern & kürzen; Reste $a/n^s -> 0$ streichen.
- Differenzen mit Wurzeln: konjugiert erweitern ($->$ Binom Trick).
- Form $0/0$, $oo/oo$: vereinfachen, sonst Taylor oder L'Hospital.
- Form $1^oo$, $0^0$, $oo^0$: logarithmieren ($->$ Log Trick).
- Sandwich-Theorem.
- Vergleich mit Referenz-Folgen.
- Grenzwert durch Umformen ermitteln.
- Definition der Konvergenz / Limes anwenden.
- Rekursive Folgen: Weierstrass, Schranke abschätzen, per Induktion beweisen.
- Cauchy-Kriterium.
- *Majorante:* $|a_n-a|<=b_n$ und $b_n->0$ $=>$ $a_n->a$.

Bsp. $d_1=3, d_(n+1)=sqrt(3d_n-2)$. Induktion: monoton fallend. Grenzwert-Kandidat: $d=lim d_n=lim d_(n+1)=sqrt(3d-2) => d^2=3d-2 => d=2$. Zeige untere Schranke $d=2$ per Induktion.

#strat[Strategie – Divergenz von Folgen]
- *Minorante:* $0<=b_n<=a_n$ und $b_n->oo$ $=>$ $a_n->oo$.
- Alternierend: zeige $lim a_(p_(1)(n)) eq.not lim a_(p_(2)(n))$.

#strat[Strategie – Spezielle Limes-Tricks]
*Binom Trick* (Differenzen mit Wurzeln konjugiert erweitern):
$ lim_(x->oo)(sqrt(x+5)-sqrt(x-3)) = lim_(x->oo) ((x+5)-(x-3))/(sqrt(x+5)+sqrt(x-3)) $
*Substitution Trick* (z.B. $u=1/x$):
$ lim_(x->oo) x^2(1-cos(1/x)), \ u=1/x: quad lim_(u->0) (1-cos u)/u^2 = lim (sin u)/(2u)=lim (cos u)/2 = 1/2 $
*Log Trick* – Formen $1^oo, oo^0$: $f(x)^(g(x))=e^(g(x) dot ln f(x))$, dann Exponent betrachten (Bernoulli / vereinfachen).
$ lim u(x)^(v(x)) = e^(lim[v(x) ln u(x)]) $

#sub[Rechnen mit Reihen]
#bx[
  #S Seien $sum a_k$, $sum b_j$ konvergent, $alpha in CC$:
  + $sum(a_k+b_k)=sum a_k + sum b_k$ (konvergiert)
  + $sum(alpha a_k)=alpha sum a_k$ (konvergiert)
]

#sub[Cauchy-Kriterium für Reihen]
#S $sum_(k=1)^oo a_k$ konvergiert g.d.w. $forall epsilon>0 med exists N: |sum_(k=n)^m a_k|<epsilon med forall m>=n>=N$.

*(Nullfolgenkriterium)* $sum a_n$ divergiert, falls $lim a_n eq.not 0$.

#K Sei $a_n>=0, s_n=a_1+dots+a_n$: $sum a_n$ konvergiert $<==> (s_n)$ v.o.b.

Falls $0<=b_n<=a_n$, konvergiert auch $sum b_n$.

Falls $a_n>=0$ und $sum a_n$ divergent: $sum a_n=oo$.

#sub[Absolute Konvergenz]
#D $sum a_k, a_n in CC$, heisst *absolut konvergent*, falls $sum |a_k|$ konvergiert.
#bx[#S Eine absolut konvergente Reihe ist konvergent, und $|sum_(k=1)^oo a_k| <= sum_(k=1)^oo |a_k|$ (verallg. Dreiecksungl.).]
#B bedingt konvergent: konvergiert, aber nicht absolut.

#sub[Konvergenzkriterien]
#bx[
  #K *(Majoranten-/Minorantenkriterium)* $0<=a_k<=b_k$ ab $k>=K$:
  + *Majorante $b_k$:* $sum b_k$ konv. $=>$ $sum a_k$ konv. (gross $=>$ klein).
  + *Minorante $a_k$:* $sum a_k$ div. $=>$ $sum b_k$ div. (klein $=>$ gross).
]

#bx[
  #S *(Leibniz)* $(a_n)$ monoton fallend, $a_n>=0$, $lim a_n=0$. Dann konvergiert $S:=sum_(k=1)^oo (-1)^(k+1)a_k$ und $a_1-a_2<=S<=a_1$. Restglied: $|sum_(k=n+1)^oo (-1)^(k+1)a_k|<=a_(n+1)$.
]

#D Eine *Umordnung* von $sum a_k$ ist $sum a_(sigma(k))$ mit einer Bijektion $sigma: NN^* -> NN^*$.

#S *(Dirichlet)* Konvergiert eine Reihe absolut, so konvergiert jede Umordnung mit demselben Grenzwert ($sigma: NN^* -> NN^*$ bijektiv).

#S *(Riemann)* Konvergiert die Reihe bedingt (d.h. konvergent, aber nicht absolut), so gibt es zu jedem $x in RR$ eine Anordnung mit $sum a_(sigma(k))=x$.
#B Bsp.: alternierende harmon. Reihe $sum (-1)^(k+1)/k$ lässt sich auf jeden Wert $x in RR$ umordnen.

*Quotientenkriterium:* $a_n eq.not 0$, $limsup |a_(n+1)/a_n|<1 =>$ abs. konv.; $liminf|a_(n+1)/a_n|>1 =>$ div. Äquiv. mit $lim$.

*Wurzelkriterium:* $limsup root(n, |a_n|)<1 =>$ abs. konv.; $>1 =>$ div.

*Verdichtungskriterium (Cauchy):* $(a_n)$ monoton fallend, $a_n>=0$: $sum a_n$ konv. $<==> sum 2^n a_(2^n)$ konv.

Bsp. $a_n=z^n/n!$: $|a_(n+1)/a_n|=|z|/(n+1)<1$ für $n>|z| => sum z^n/n!$ konvergiert.

#sub[Potenzreihen]
Form $sum_(k=0)^oo c_k (x-a)^k = c_0+c_(1)(x-a)+c_(2)(x-a)^2+dots$ (Entwicklungspunkt $a$).
#bx[
  #D Der *Konvergenzradius* $R$ entspricht:
  $
    R = cases(+oo & "falls " rho=0, 1\/rho & "falls " rho>0, 0 & "falls " rho=oo) quad rho=limsup_(k->oo) root(k, |c_k|)
  $
  *Alternativ (Quotienten, oft einfacher bei Fakultäten):*
  $ R = lim_(n->oo) abs(c_n)/abs(c_(n+1)) $
]

#K $sum c_k (x-a)^k$ konvergiert absolut für $|x-a|<R$, divergiert für $|x-a|>R$.

Fall $|x-a|=R$ separat prüfen.

#S Potenzreihe $f(x)=sum c_k x^k$ mit $R>0$ konvergiert gleichmässig auf $[-r,r]$ für alle $r<R$; $f: (-R,R) -> RR$ ist stetig.

#sub[Doppelreihen]
Bei $(a_(i j))_(i,j>=0)$ können $sum_i sum_j a_(i j)$ und $sum_j sum_i a_(i j)$ verschiedene Grenzwerte haben.

Konvergiert $sum_(i,j) a_(i j)$ absolut, sind beide gleich und jede Anordnung konvergiert dazu.

#sub[Das Cauchy Produkt]
#bx[
  #D Cauchy-Produkt von $sum a_i, sum b_j$:
  $ sum_(n=0)^oo sum_(j=0)^n (a_(n-j) b_j) = a_0 b_0 + (a_0 b_1 + a_1 b_0)+dots $
  Konvergiert (mind.) eine der beiden Reihen absolut, konvergiert auch das Produkt gegen $(sum a_i)(sum b_j)$.
]

#bx[
  #S Sei $f_n: NN -> RR$ mit
  + $f(j):=lim_n f_(n)(j)$ existiert $forall j$
  + $exists g: NN->[0,oo)$ mit $|f_(n)(j)|<=g(j)$ und $sum g(j)$ konv.

  Dann $sum_j f(j) = lim_n sum_j f_(n)(j)$.
]

#sub[Integral Test]
Sei $f$ stetig, positiv, monoton fallend auf $[k,oo)$, $f(n)=a_n$:
$ integral_k^oo f(x)dif x " konv." <==> sum_(n=k)^oo a_n " konv." $
(Analog für Divergenz.)

#strat[Strategie – Konvergenz von Reihen]
- Spezielle Reihe? (Geometrisch, Teleskop, Harmonisch, Zeta)
- $lim a_n=0$? (Nullfolgenkriterium)
- Fakultäten / Exponentialausdrücke: Quotientenkriterium.
- Terme mit $n$-ter Potenz: Wurzelkriterium.
- Positive Terme: konvergenter Majorant / divergenter Minorant, sonst Integraltest.
- Alternierend: Leibnizkriterium.
- Danach absolute Konvergenz separat prüfen.

#chapter[Stetigkeit und Funktionen]

#sub[Definitionen]
#bx[
  #D $D subset.eq RR, x_0 in D$. $f: D->RR$ ist *stetig* in $x_0$, falls $forall epsilon>0 med exists delta>0$ so dass $forall x in D$:
  $ |x-x_0|<delta ==> |f(x)-f(x_0)|<epsilon $
]
Alternativ (Folgenstetigkeit): $forall (a_n)->x_0$ gilt $f(lim a_n)=f(x_0)=lim f(a_n)$.

#D $f$ ist *stetig*, falls sie in jedem Punkt von $D$ stetig ist.

*Gleichmässige Stetigkeit:* $forall epsilon>0 med exists delta>0 med forall x,y in D: |x-y|<delta => |f(x)-f(y)|<epsilon$.

Auf kompaktem Intervall stetig $=>$ dort gleichmässig stetig.

*Lipschitz-stetig:* $exists L>=0 med forall x,y in D: |f(x)-f(y)|<=L|x-y|$. (Lipschitz $=>$ gleichmässig stetig.)

#sub[Rechnen mit Stetigkeit]
$f,g$ in $x_0$ stetig, $lambda in RR$:
+ $f+g, lambda f, f dot g$ stetig in $x_0$
+ $g(x_0) eq.not 0 => f/g$ stetig in $x_0$
+ $|f|, max(f, g), min(f, g)$ stetig
+ Polynome sind auf ganz $RR$ stetig
+ $sin, cos: RR->RR$ stetig
+ $e^x$ auf ganz $RR$ stetig
+ $P,Q$ Polynome, $Q eq.not 0$, Nullstellen $x_1,dots,x_m$: $P/Q$ stetig auf $RR without {x_1,dots,x_m}$
+ $f$ in $x_0$, $g$ in $f(x_0)$ stetig $=> g compose f$ in $x_0$ stetig

#sub[Zwischenwertsatz]
#bx[
  #S Sei $I subset.eq RR$ Intervall, $f: I->RR$ stetig, $a,b in I$. Für jedes $c$ zwischen $f(a)$ und $f(b)$ gibt es $z$ zwischen $a,b$ mit $f(z)=c$.
]
Anwendungen:
+ $f(a) f(b)<0 => exists c: f(c)=0$
+ Polynom mit ungeradem Grad hat mind. eine reelle Nullstelle

#sub[Min-Max Satz]
#D $I subset.eq RR$ *kompakt*, falls $I=[a,b]$ mit $a<=b$.
#bx[#S $f: [a,b]->RR$ stetig $=> exists u,v in I$ mit $f(u)<=f(x)<=f(v) med forall x in I$. Insbesondere ist $f$ beschränkt.]

#sub[Satz der Umkehrabbildung]
#bx[
  #S $I subset.eq RR$ Intervall, $f: I->RR$ stetig, streng monoton. Dann ist $f(I)=:J$ ein Intervall und $f^(-1): J->I$ stetig, streng monoton.
]
Bsp. $f: [0,oo)->[0,oo), x |-> x^n$ hat Umkehrung $x |-> root(n, x)$.

#sub[Konvergenz von Funktionenfolgen]
#D Eine *Funktionenfolge* ist eine Abbildung $NN->RR^D$, $n |-> f_n$ (d.h. jedes $f_n: D->RR$; $RR^D$ = Menge aller Funktionen $D->RR$). Für festes $x in D$ ist $(f_(n)(x))_(n in NN)$ eine gewöhnliche Folge.

$(f_n)$ konvergiert *punktweise* gegen $f$, falls $forall x: f(x)=lim f_(n)(x)$, d.h. $forall epsilon, forall x, exists N, forall n>=N: |f_(n)(x)-f(x)|<epsilon$.

$(f_n)$ konvergiert *gleichmässig* gegen $f$, falls $forall epsilon, exists N, forall n>=N, forall x: |f_(n)(x)-f(x)|<epsilon$.

#B gleichmässig $=>$ punktweise, nicht umgekehrt.
#bx[#S $f_n$ stetig und gleichmässig $-> f$ $==>$ $f$ stetig. (Für punktweise i.A. nicht.)]

#strat[Strategie – Konvergenz von Funktionenfolgen]
#steps[
  + Punktweisen Limes $f$ auf $D$ finden.
  + Auf gleichmässige Konvergenz prüfen:
    - Indirekt: $f$ unstetig $=>$ nicht gleichmässig; $f_n$ & $f$ stetig, $(f_n)$ monoton in $n$, $D$ kompakt $=>$ gleichmässig (Dini).
    - Direkt: $sup_(x in D)|f_(n)(x)-f(x)|$ berechnen (evtl. Ableitung $=0$), dann $lim_(n->oo)$; ist er $0$, konvergiert $f_n$ gleichmässig.
]

#sub[Konvergenz von Funktionenreihen]
#D $sum_(k=1)^oo f_(k)(x)$ konvergiert gleichmässig, falls $S_(n)(x)=sum_(k=0)^n f_(k)(x)$ gleichmässig konvergiert.
#bx[
  #S *(Weierstrass-M)* $f_n$ stetig, $|f_(n)(x)|<=c_k med forall x$. Konvergiert $sum c_k$, so konvergiert $sum f_(k)(x)$ gleichmässig gegen eine stetige Funktion $f$.
]

#chapter[Differentialrechnung]

#sub[Grenzwerte von Funktionen]
$x_0 in RR$ ist *Häufungspunkt* von $D$ falls $forall delta>0: ((x_0-delta,x_0+delta) without {x_0}) inter D eq.not emptyset$.

#bx[
  Sei $x_0$ Häufungspunkt von $D$. $A in RR$ ist *Grenzwert* von $f(x)$ gegen $x_0$, falls $forall epsilon>0 med exists delta>0$ so dass
  $ forall x in D inter ((x_0-delta,x_0+delta) without {x_0}): |f(x)-A|<epsilon $
]
#S $(a_n)$ beschränkt:
+ hat mind. einen Häufungspunkt
+ genau einer $=>$ konvergiert dagegen

#B
+ $lim_(x->x_0) f(x)=A <==> forall (a_n) in D without {x_0}, a_n->x_0: f(a_n)->A$
+ $x_0 in D$: $f$ stetig $<==> lim_(x->x_0) f=f(x_0)$
+ $lim(f+g)=lim f+lim g$
+ $lim(f g)=lim f dot lim g$
+ $f<=g => lim f<=lim g$
+ Sandwich

#S $y_0=lim_(x->x_0) f(x)$, $g$ stetig in $y_0$ $=> lim_(x->x_0) g(f(x))=g(y_0)$.

#sub[Linksseitiger / Rechtsseitiger Grenzwert]
Existiert der Grenzwert von $f$ eingeschränkt auf $D inter (x_0,+oo)$ für $x->x_0$, heisst er $lim_(x->x_0^+) f(x)$ (rechtsseitig). Analog linksseitig.
Erweiterung: $lim_(x->x_0^+) f=+oo$ falls $forall epsilon exists delta forall x in D inter (x_0,x_0+delta): f(x)>1/epsilon$ (analog $-oo$).

#sub[Differenzierbarkeit]
#bx[
  Sei $x_0 in D$ Häufungspunkt. $f$ ist in $x_0$ *differenzierbar*, falls
  $ lim_(x->x_0) (f(x)-f(x_0))/(x-x_0) = lim_(h->0) (f(x_0+h)-f(x_0))/h $
  existiert; Wert $f'(x_0)$ bzw. $(dif f)/(dif x)(x_0)$.
]
#bx[
  #S *(Weierstrass)* Äquivalent zur Differenzierbarkeit: $exists c in RR, r: D->RR$ mit $f(x)=f(x_0)+c(x-x_0)+r(x)(x-x_0)$, $r(x_0)=0$, $r$ stetig in $x_0$. Dann $c=f'(x_0)$ eindeutig.
]
#K $f$ diff.bar in $x_0 => f$ stetig in $x_0$.
#B Tangente: $y=f(x_0)+f'(x_0)(x-x_0)$.

#K $f: D->E$ bijektiv, in $x_0$ diff.bar, $f'(x_0) eq.not 0$, $f^(-1)$ stetig in $y_0=f(x_0)$. Dann $(f^(-1))'(y_0)=1/(f'(f^(-1)(y_0)))$.

#sub[Rechnen mit Ableitungen]
+ $(f+g)'=f'+g'$
+ $(f dot g)'=f' g + g' f$
+ $(f/g)'=(f' g - f g')/g^2$, $g eq.not 0$
+ $(g compose f)'(x_0)=g'(f(x_0)) dot f'(x_0)$
+ $(f^(-1))'(y_0)=1/(f'(x_0))$, $y_0=f(x_0)$
+ $(a^(f(x)))'=ln(a) dot a^(f(x)) dot f'(x)$
+ $(f^g)'=f^g dot [ln(f) dot g]'$

#B Für gerade $k$: $cosh^((k))=cosh$; ungerade $k$: $cosh^((k))=sinh$ (analog $sinh$).

#sub[Aussagen der Ableitung]
+ lok. Maximum in $x_0$: $f'(x_0)=0$ und $f''(x_0)<0$
+ lok. Minimum in $x_0$: $f'(x_0)=0$ und $f''(x_0)>0$
+ lok. Extremum: $f'(x_0)=0$ und $f''(x_0) eq.not 0$
+ Wendepunkt: Das Krümmungsverhalten wechselt bei $x_0$.
  Falls $f''$ stetig ist, wechselt $f''$ dort das Vorzeichen.
+ Sattelpunkt: Wendepunkt mit waagrechter Tangente,
  also zusätzlich $f'(x_0)=0$.

Für $f,g: [a,b]->RR$ stetig, in $(a,b)$ diff.bar:
+ $f'=0$ auf $(a,b) => f$ konstant
+ $f'=g'$ auf $(a,b) => f=g+c$
+ $f'<=[<]0 => f$ [streng] monoton fallend
+ $f'>=[>]0 => f$ [streng] monoton wachsend

#sub[Satz von Rolle]
#bx[#S $f: [a,b]->RR$ stetig, in $(a,b)$ diff.bar, $f(a)=f(b) => exists xi in (a,b): f'(xi)=0$.]

#sub[Mittelwertsatz]
#bx[#S $f$ stetig, in $(a,b)$ diff.bar $=> exists xi: f(b)-f(a)=f'(xi)(b-a)$.]
#B $f'(xi) = (f(b)-f(a))/(b-a)$

#sub[Satz von L'Hospital]
Verallg. MWS: $g'(xi)(f(b)-f(a))=f'(xi)(g(b)-g(a))$.

Ist $g' eq.not 0$: $(f(b)-f(a))/(g(b)-g(a))=(f'(xi))/(g'(xi))$.
#bx[
  #S Falls $lim_(x->b) f=0, lim_(x->b) g=0$ und $lim_(x->b) (f'(x))/(g'(x))=lambda$ existiert, dann
  $ lim_(x->b) (f(x))/(g(x)) = lim_(x->b) (f'(x))/(g'(x)) = lambda $
]
Gilt auch für $b=+oo, x->a^+, lambda=+oo, lim f=lim g=oo$.

Form "$oo/oo$": umschreiben; "$0 dot oo$": $f/(1/g)$; "$oo-oo$": gleicher Nenner.

#sub[Krümmungsverhalten: Konvexität und Konkavität]

Sei $f: I -> RR$.

#bx[
  #D $f$ ist [streng] *konvex* auf $I$, falls für alle
  $x,y in I$ und $lambda in [0,1]$ gilt:

  $
    f(lambda x + (1-lambda)y)
    <= [<]
    lambda f(x) + (1-lambda)f(y).
  $

  Der Graph liegt zwischen zwei Punkten unterhalb der
  Verbindungsgeraden.
]

#bx[
  #D $f$ ist [streng] *konkav* auf $I$, falls für alle
  $x,y in I$ und $lambda in [0,1]$ gilt:

  $
    f(lambda x + (1-lambda)y)
    >= [>]
    lambda f(x) + (1-lambda)f(y).
  $

  Der Graph liegt zwischen zwei Punkten oberhalb der
  Verbindungsgeraden.
]

Falls $f$ differenzierbar ist:

$
  f " konvex"
  <==>
  f' " monoton wachsend",
$

$
  f " konkav"
  <==>
  f' " monoton fallend".
$

Falls $f$ zweimal differenzierbar ist:

$
  f " konvex"
  <==>
  f'' >= 0,
  quad
  f " streng konvex"
  <==
  f'' > 0,
$

$
  f " konkav"
  <==>
  f'' <= 0,
  quad
  f " streng konkav"
  <==
  f'' < 0.
$

#K Für $x_0 < x < x_1$ gilt:

$
  f " konvex"
  <==>
  (f(x)-f(x_0))/(x-x_0)
  <=
  (f(x_1)-f(x))/(x_1-x),
$

bei Konkavität gilt das umgekehrte Ungleichheitszeichen.

#B Summen konvexer Funktionen und nichtnegative Vielfache
konvexer Funktionen sind konvex. Analog für konkave Funktionen.

#bx[
  *Wendestelle*

  Eine Stelle $x_0$ ist eine Wendestelle, wenn sich das
  Krümmungsverhalten dort ändert:

  $
    f'' " wechselt bei " x_0 " das Vorzeichen".
  $

  Die Bedingung $f''(x_0)=0$ allein ist nur notwendig,
  aber nicht hinreichend.
]

#sub[Höhere Ableitungen]
+ $f$ ist $n$-mal diff.bar in $D$, falls $f^((n-1))$ diff.bar ist. $n$-mal diff.bar $=> (n-1)$-mal stetig diff.bar.
+ $f$ *glatt*, falls $forall n>=1$ $n$-mal diff.bar.

#B Polynome, $e^x, sin, cos$ sind glatt.

*Rechnen:*
+ $(f+g)^((n))=f^((n))+g^((n))$
+ $(f g)^((n))=sum_(k=0)^n binom(n, k) f^((k)) g^((n-k))$
+ $f/g$ $n$-mal diff.bar falls $g eq.not 0$
+ $g compose f$ $n$-mal diff.bar

#sub[Potenzreihe (Ableitung)]
#S $f_n$ einmal stetig diff.bar; $(f_n)->f$ und $(f_n')->p$ gleichmässig $=> f$ stetig diff.bar mit $f'=p$.
#bx[
  #S $f(x)=sum_(k=1)^oo c_k (x-x_0)^k$, Konvergenzradius $R>0$, ist auf $(x_0-R,x_0+R)$ diff.bar mit
  $ f'(x)=sum_(k=1)^oo k dot c_k (x-x_0)^(k-1) $
]

#sub[Taylor Approximation]
#bx[
  #S $f: [a,b]->RR$ stetig, in $(a,b)$ $(n+1)$-mal diff.bar. $forall a<x<=b med exists xi in (a,x)$:
  $ f(x)=sum_(k=0)^n (f^((k))(a))/k! (x-a)^k + underbrace((f^((n+1))(xi))/(n+1)! (x-a)^(n+1), R_n) $
]
$T_n$: Taylor-Polynom, $R_n$: Fehlerabschätzung.

#bx[
  #S *(Integral-Restterm)* Ist $f$ auf $[a,b]$ $(n+1)$-mal stetig diff.bar, so gilt $forall x in [a,b]$:
  $ f(x)=sum_(k=0)^n (f^((k))(a))/k! (x-a)^k + underbrace(integral_a^x f^((n+1))(s) (x-s)^n/n! dif s, R_n) $
]

Für $R_n$ nimm $xi in (a,x)$ so dass Fehler maximal.

#sub[Spezielle Punkte]
$f'(x_0)=dots=f^((n))(x_0)=0$:
+ $n$ gerade, $x_0$ lok. Extremalstelle $=> f^((n+1))(x_0)=0$
+ $n$ ungerade, $f^((n+1))(x_0)>0 => x_0$ strikte lok. Minimalstelle
+ $n$ ungerade, $f^((n+1))(x_0)<0 => x_0$ strikte lok. Maximalstelle

#strat[Strategie – Kurvendiskussion]
Für $f: D->RR$ der Reihe nach:
#steps[
  + *Definitionsbereich $D$:* Nenner $eq.not 0$, Log-Argument $>0$, Radikand $>=0$ (gerade Wurzeln).
  + *Symmetrie:* $f(-x)=f(x)$ achsensymmetrisch; $f(-x)=-f(x)$ punktsymmetrisch.
  + *Achsenschnittpunkte:* $f(x)=0$ lösen; falls $0 in D$, $y$-Achse bei $(0,f(0))$.
  + *Grenzwerte:* $x->plus.minus oo$ und Randstellen von $D$.
  + *Asymptoten:* $lim_(x->a)|f|=oo =>$ vertikal $x=a$; $lim_(x->plus.minus oo)f=c =>$ horizontal $y=c$.
  + *Kandidaten:* Randpunkte von $D$, Stellen ohne Ableitung, Lösungen von $f'(x)=0$.
  + *Monotonie & Extrema:* Vorzeichen von $f'$ zwischen den Kandidaten ($->$ Aussagen der Ableitung).
  + *Krümmung & Wendestellen:* $f''(x)=0$ lösen, Vorzeichen von $f''$ prüfen ($->$ Krümmungsverhalten).
  + *Werte einsetzen:* Koordinaten der Extrem- und Wendepunkte via $f$; alles zur Skizze zusammensetzen.
]
#B Globale Extrema auf $[a,b]$: Funktionswerte an *allen* Kandidaten vergleichen.

#chapter[Integralrechnung]

#sub[Treppenfunktion]
#D $f: [a,b]->RR$ heisst *Treppenfunktion*, falls es eine Zerlegung $a=x_0<x_1<dots<x_n=b$ gibt, sodass $f$ auf jedem offenen Teilintervall $(x_(k-1),x_k)$ konstant ist (Wert $c_k$).

Integral der Treppenfunktion:
$ integral_a^b f(x) dif x := sum_(k=1)^n c_k (x_k - x_(k-1)) $

#sub[Das Riemann Integral]
Eine *Zerlegung* $P$ von $I=[a,b]$ ist endliche Teilmenge $P subset.eq [a,b]$ mit ${a,b} subset.eq P$. $delta_i$: Länge von $[x_(i-1),x_i]$.
$ L(f,P)=sum_(i=1)^n f_i delta_i, med f_i=inf_([x_(i-1),x_i]) f, quad U(f,P)=sum_(i=1)^n F_i delta_i, med F_i=sup f $
Verfeinerung $P'$: $L(f,P)<=L(f,P')<=U(f,P')<=U(f,P)$.

$L(f)=sup_P L(f,P)$, $U(f)=inf_P U(f,P)$.
#bx[
  #S Eine beschränkte Funktion ist *Riemann-integrierbar*, falls $L(f)=U(f)$:
  $ L(f)=integral_a^b f(x)dif x = U(f) $
  Äquiv.: $forall epsilon>0 med exists P: U(f,P)-L(f,P)<epsilon$.
]

#strat[Strategie – Integrierbarkeit zeigen]
+ $f$ stetig auf $[a,b]$ $=> f$ integrierbar
+ $f$ monoton $=> f$ integrierbar
+ $f,g$ integrierbar $=> f+g, lambda f, f g, |f|, max, min$ und $f/g$ (falls $|g|>=beta>0$) integrierbar
+ Jedes Polynom auf $[a,b]$; auch $P/Q$ falls $Q$ nullstellenfrei
+ Unterschied auf endlicher Menge ändert Integrierbarkeit nicht

#sub[Rechnen mit Integralen]
$ integral_a^b (lambda_1 f + lambda_2 g)dif x = lambda_1 integral_a^b f dif x + lambda_2 integral_a^b g dif x $
$
  integral_(a+c)^(b+c) f(x)dif x = integral_a^b f(t+c)dif t, quad integral_a^b f(c t)dif t = 1/c integral_(a c)^(b c) f(x)dif x
$

#sub[Ungleichungen und Mittelwertsatz]
+ $f<=g => integral_a^b f <= integral_a^b g$
+ $|integral_a^b f| <= integral_a^b |f|$
+ $|integral_a^b f g| <= sqrt(integral_a^b f^2) dot sqrt(integral_a^b g^2)$ (Cauchy-Schwarz)

#bx[#S $f: [a,b]->RR$ stetig $=> exists xi in [a,b]: integral_a^b f(x)dif x = f(xi)(b-a)$.]
Folgt: $g>=0$ beschränkt integrierbar, $f$ stetig $=> exists xi: integral_a^b f g = f(xi) integral_a^b g$.

#sub[Fundamentalsatz der Analysis]
#bx[
  Sei $f: [a,b]->RR$ stetig. Dann ist $F(x)=integral_a^x f(t)dif t$ stetig diff.bar mit $F'(x)=f(x) med forall x in [a,b]$.
]
$F$ heisst *Stammfunktion* von $f$ (bis auf additive Konstante eindeutig) und $integral_a^b f(x)dif x = F(b)-F(a)$.

#sub[Partielle Integration]
#bx[
  $f,g$ stetig diff.bar:
  $ integral_a^b f g' dif x = [f g]_a^b - integral_a^b f' g dif x $
]
Wahl von $f$ (absteigende Priorität):
- $"arc"$-/$log$-Fkt., $x^n, 1/(1-x^2), 1/(1+x^2)$
- $x^n, arcsin, arccos, arctan$
- "egal": $e^x, sin, cos, sinh, cosh$

#sub[Substitution]
#bx[
  $phi: [a,b]->RR$ stetig diff.bar, $phi([a,b]) subset.eq I$, $f: I->RR$ stetig:
  $ integral_a^b f(phi(t)) phi'(t) dif t = integral_(phi(a))^(phi(b)) f(x)dif x $
]
Bsp. $integral (x)/(sqrt(9-x^2))dif x$, $t=sqrt(9-x^2) => dif x = -t dif t\/sqrt(9-t^2) => integral -dif t = -t$, rücksub. $-sqrt(9-x^2)$.

*Nützliche Substitutionen:*
+ $e^x, sinh, cosh$: $t=e^(a x), dif x=(dif t)/(a t)$
+ $log(x)$: $t=log x, x=e^t, dif x=e^t dif t$
+ gerade $n$: $t=tan x$, $sin^2=t^2/(1+t^2), cos^2=1/(1+t^2)$
+ ungerade $n$: $t=tan(x/2)$, $sin=2t/(1+t^2), cos=(1-t^2)/(1+t^2)$
+ $integral sqrt(1-x^2)$: $x=sin$ oder $cos$
+ $integral sqrt(1+x^2)$: $x=sinh$

#strat[Strategie – Berechnung von Integralen]
*Bruchform:*
- einfacher Nenner
- Partialbruchzerlegung
- $u'/(2sqrt(u))$ oder $u'/u$ erkennen $=> sqrt(u)$ oder $log|u|$

*Produktform:*
- partielle Integration (evtl. mehrmals)
- Kettenregel

*Potenzen:* $integral f^c = integral(f^c dot 1)$ oder $integral(f^(c-1) dot f)$, dann part. Int.

*Exponentenform:* $e/log$-Trick bei Variable im Exponenten.

*Produkt mit $e, sin, cos$:* mehrmals part. Int. ($sin,cos$ als $g'$, $e$ als $f$).

*Summe im Integral:* herausziehen (Reihe muss gleichmässig konvergieren).

#sub[Integration von konvergenten Reihen]
#bx[
  $f_n$ integrierbar, gleichmässig $-> f$. Dann $f$ integrierbar und
  $ lim_(n->oo) integral_a^b f_n = integral_a^b lim_(n->oo) f_n = integral_a^b f $
]
Gleichmässig konv. Reihe: $sum_(n=0)^oo integral_a^b f_n = integral_a^b sum_(n=0)^oo f_n$.

Potenzreihe $f(x)=sum c_k x^k$, $R>0$: $forall 0<=r<R$ auf $[-r,r]$ integrierbar, $integral_0^x f(t)dif t = sum_(k=0)^oo (c_k)/(k+1) x^(k+1)$.

#sub[Stirling'sche Formel]
$ n! approx sqrt(2 pi n) dot n^n/e^n, quad lim_(n->oo) (n!)/(sqrt(2 pi n) n^n\/e^n)=1 $
$ n!=sqrt(2 pi n) n^n/e^n dot exp(1/(12n)+R_(3)(n)), quad |R_(3)(n)|<=sqrt(3)/216 dot 1/n^2 $

#sub[Uneigentliche Integrale]
$f: [a,oo)->RR$ beschränkt & integrierbar auf $[a,b]$. Falls $lim_(b->oo) integral_a^b f$ existiert, heisst $f$ auf $[a,oo)$ integrierbar mit $integral_a^oo f$.

Analog für $0<=f<=g$ ab $A$: $integral_A^oo g$ konv. $=>$ $integral_A^oo f$ konv.; $integral_A^oo f$ div. $=>$ $integral_A^oo g$ div.

$f: (a,b]->RR$ integrierbar, falls $lim_(epsilon->0^+) integral_(a+epsilon)^b f$ existiert.

Bsp. $f(t)=t^x$: auf $(0,1)$ integrierbar für $x>-1$: $integral_0^1 t^x dif t=1/(x+1)$; auf $[1,oo)$ für $x<-1$: $integral_1^oo t^x dif t = -1/(1+x)$.

#sub[Partialbruchzerlegung]
Ziel: $R(x)=P(x)/Q(x)$ als Summe einfach integrierbarer Brüche schreiben.

#steps[
  + Falls $deg P>=deg Q$: Polynomdivision.
  + $Q$ über $RR$ faktorisieren (quadratisch irreduzibel $<==> p^2-4q<0$).
  + *Ansatz* pro Faktor, mit Vielfachheit:
    - $(x-alpha)^m: quad sum_(k=1)^m A_k/(x-alpha)^k$
    - $(x^2+p x+q)^n: quad sum_(k=1)^n (B_k x+C_k)/((x^2+p x+q)^k)$
  + Mit $Q$ multiplizieren, Koeffizienten vergleichen oder $x$-Werte einsetzen ($->$ Zuhaltemethode).
  + Gliedweise integrieren.
]

*Zuhaltemethode* (nur für einfache Linearfaktoren $(x-alpha)$): Faktor $(x-alpha)$ im Nenner zuhalten (streichen) und $x=alpha$ in den Rest einsetzen:
$ A = lr(P(x)/(Q(x)\/(x-alpha)) |)_(x=alpha) $
Bsp. $1/(x(x+1))$: $quad A = lr(1/(x+1)|)_(x=0) = 1$, $quad B = lr(1/x|)_(x=-1) = -1$
$ ==> 1/(x(x+1)) = 1/x - 1/(x+1) $
#B *Warum:* Ansatz mit $(x-alpha)$ multiplizieren $->$ jeder andere Term behält einen Faktor $(x-alpha)$ und verschwindet bei $x=alpha$; nur $A$ bleibt stehen. Bei mehrfachen Faktoren $(x-alpha)^m$ liefert es nur $A_m$.

*Grundintegrale.*
$ integral (dif x)/(x-a) = ln|x-a|, quad integral (dif x)/((x-a)^n) = (-1)/((n-1)(x-a)^(n-1)) $
$ integral (2x+p)/(x^2+p x+q) dif x = ln|x^2+p x+q| $
$ integral (dif x)/(x^2+p x+q) = 2/sqrt(4q-p^2) arctan((2x+p)/sqrt(4q-p^2)) $

#B Zähler eines quadratischen Terms aufspalten: $B x+C = B/2 (2x+p) + (C - (B p)/2)$, erster Teil $-> log$, zweiter $-> arctan$.

Bsp. $integral (x^2-x+2)/(x^3-x^2+x-1) dif x$: Nullstelle $x=1$, Polynomdiv. $=> Q=(x-1)(x^2+1)$. Ansatz $C/(x-1)+(A+B x)/(x^2+1)$: $B=0, A=-1, C=1 => ln|x-1|-arctan(x)+c$.

#chapter[Sonstiges]

#sub[Injektiv / Surjektiv]
$f: X->Y$: *Injektiv*: $f(a)=f(b) => a=b$.

*Surjektiv*: $forall y in Y med exists x: f(x)=y$.

$f$ injektiv, $g$ surjektiv $=> g compose f$ bijektiv.

*Injektivität:* $f$ inj. $<==> f$ streng monoton $<== f'>0$ oder $f'<0$ (hinreichend, nicht notwendig: $x^3$).

*Surjektivität* (Zwischenwertsatz, Bild $(a,b)$):
+ $lim_(x->oo) f=b, lim_(x->-oo) f=a$
+ $y in (a,b)$: $exists x_1<x_2: f(x_1)<y<f(x_2)$, ZWS $=> exists c: f(c)=y$

#sub[Nützliche Formeln]
$ a x^2+b x+c=0 => x=(-b plus.minus sqrt(b^2-4a c))/(2a) $
$ b^n-a^n=(b-a)(b^(n-1)+b^(n-2)a+dots+a^(n-1)) $
$ a^n+b^n=(a+b)(a^(n-1)-a^(n-2)b+dots+b^(n-1)) quad (n "ungerade") $
$ binom(n, k)=(n!)/((n-k)! k!); quad sqrt(a_k a_(k+1)) <= (a_k+a_(k+1))/2 $

*Binomische Formeln:*
$ (a plus.minus b)^2=a^2 plus.minus 2a b+b^2, quad (a+b)(a-b)=a^2-b^2 $
$ (a plus.minus b)^3=a^3 plus.minus 3a^2 b+3a b^2 plus.minus b^3 $

#sub[Bernoulli Ungleichung]
$ (1+x)^n >= 1+n x quad forall n in NN, x>-1 $

#sub[Young'sche Ungleichung]
$ forall epsilon>0, forall x,y in RR: 2|x y| <= epsilon x^2 + 1/epsilon y^2 $

#sub[Binomialsatz]
$ (x+y)^n = sum_(k=0)^n binom(n, k) x^(n-k) y^k $

#sub[Die Exponentialfunktion]
#bx[
  #D $exp(z)=sum_(n=0)^oo z^n/n! = 1+z+z^2/2+z^3/6+z^4/24+dots=e^z$
]
$exp(z)=lim_(n->oo)(1+z/n)^n$.

Stetig, streng monoton wachsend, surjektiv.
+ $exp(x)exp(y)=exp(x+y)$
+ $exp(x)>1 med forall x>0$
+ $x^a=exp(a ln x)$, $x^0=1$
+ $exp(i z)=cos(z)+i sin(z)$
+ $exp(i pi/2)=i$, $exp(i pi)=-1$, $exp(2 i pi)=1$

#sub[Der natürliche Logarithmus]
$ln: (0,oo)->RR$, Umkehrung von $exp$, streng monoton wachsend, stetig.
$ln 1=0$; $ln e=1$; $ln(a b)=ln a+ln b$; $ln(a/b)=ln a-ln b$. \
$ln(x^a)=a ln x$; $x^a x^b=x^(a+b)$; $(x^a)^b=x^(a b)$. \
$ln(1+x)=sum_(n=1)^oo ((-1)^(n-1))/n x^n$ ($-1<x<=1$). $log_(b)(a)=(ln a)/(ln b)$.

#sub[Trigonometrische Funktionen]
$ sin(z)=sum_(n=0)^oo ((-1)^n z^(2n+1))/(2n+1)! = (e^(i z)-e^(-i z))/(2i) $
$ cos(z)=sum_(n=0)^oo ((-1)^n z^(2n))/(2n)! = (e^(i z)+e^(-i z))/2 $
$sin,cos: RR->RR$ stetig; beide Reihen absolut konv., $R=+oo$.

*Symmetrie:*
+ $cos(-z)=cos z$, $quad sin(-z)=-sin z$
+ $cos(pi-x)=-cos x$, $quad sin(pi-x)=sin x$

*Pythagoras:* $cos^2 z+sin^2 z=1$.

*Additionstheoreme:*
+ $sin(z+w)=sin z cos w + cos z sin w$
+ $cos(z+w)=cos z cos w - sin z sin w$
+ $sin(2z)=2 sin z cos z$
+ $cos(2z)=cos^2 z-sin^2 z$

*Produkt $->$ Summe:*
$ sin x cos y = 1/2[sin(x+y)+sin(x-y)] $
$ cos x cos y = 1/2[cos(x-y)+cos(x+y)] $
$ sin x sin y = 1/2[cos(x-y)-cos(x+y)] $

*Tangens/Kotangens:*
$ tan z=(sin z)/(cos z) space (z in.not pi/2+pi ZZ) $
$ cot z=(cos z)/(sin z) space (z in.not pi ZZ) $
$ sin(arctan x)=x/sqrt(x^2+1), quad cos(arctan x)=1/sqrt(x^2+1) $
$ sin x=(tan x)/sqrt(1+tan^2 x), quad cos x=1/sqrt(1+tan^2 x) $

*Nullstellen:* $cos: pi/2+k pi$, $sin: k pi$. \
*Umkehrfunktionen:* \
$arcsin: [-1,1]->[-pi/2,pi/2]$ \
$arccos: [-1,1]->[0,pi]$ \
$arctan: RR->(-pi/2,pi/2)$

*Funktionswerte:*
#block(breakable: false, width: 100%, text(size: 6.6pt, table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  inset: (x: 3pt, y: 3.6pt),
  align: center + horizon,
  stroke: innergrid,
  $alpha$, $0$, $30$, $45$, $60$, $90$, $120$, $150$, $180$, $270$,
  $$, $0$, $pi/6$, $pi/4$, $pi/3$, $pi/2$, $(2pi)/3$, $(5pi)/6$, $pi$, $(3pi)/2$,
  $sin$, $0$, $1/2$, $sqrt(2)/2$, $sqrt(3)/2$, $1$, $sqrt(3)/2$, $1/2$, $0$, $-1$,
  $cos$, $1$, $sqrt(3)/2$, $sqrt(2)/2$, $1/2$, $0$, $-1/2$, $-sqrt(3)/2$, $-1$, $0$,
  $tan$, $0$, $sqrt(3)/3$, $1$, $sqrt(3)$, $-$, $-sqrt(3)$, $-sqrt(3)/3$, $0$, $-$,
)))

*Reduktionsformeln.* Zurückführen auf Winkel im 1. Quadranten ($k in ZZ$):
#block(breakable: false, width: 100%, text(size: 6.6pt, table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  inset: (x: 3pt, y: 3.6pt),
  align: center + horizon,
  stroke: innergrid,
  $$, $-alpha$, $90°-alpha$, $90°+alpha$, $180°-alpha$, $180°+alpha$, $k dot 360°-alpha$, $k dot 360°+alpha$,
  $sin$, $-sin alpha$, $cos alpha$, $cos alpha$, $sin alpha$, $-sin alpha$, $-sin alpha$, $sin alpha$,
  $cos$, $cos alpha$, $sin alpha$, $-sin alpha$, $-cos alpha$, $-cos alpha$, $cos alpha$, $cos alpha$,
  $tan$, $-tan alpha$, $cot alpha$, $-cot alpha$, $-tan alpha$, $tan alpha$, $-tan alpha$, $tan alpha$,
)))

#block(width: 100%, breakable: false)[
  *Einheitskreis.* Ein Punkt auf dem Kreis ist $(x,y)=(cos alpha, sin alpha)$: der 1. Wert ist $cos alpha$, der 2. Wert $sin alpha$.

  #align(center, image("einheitskreis.png", width: 80mm))
]

#sub[Hyperbolische Funktionen]
$cosh x=(e^x+e^(-x))/2: RR->[1,oo)$; \
$sinh x=(e^x-e^(-x))/2: RR->RR$; \
$tanh x=(sinh x)/(cosh x): RR->(-1,1)$.

Es gilt $cosh^2-sinh^2=1$.

#sub[Sinus Abschätzung]
$|sin x|<=|x|$: $f(x)=x-sin x, f'(x)=1-cos x>=0, f(0)=0 => f(x)>=0$ für $x>0$.

#sub[Die Kreiszahl $pi$]
#bx[#S $pi:=inf{t>0 : sin t=0}$ (erste positive Nullstelle von $sin$).]
$sin pi=0$, $pi in (2,4)$. \
$forall x in (0,pi): sin x>0$; $e^(i pi/2)=i$.

#sub[Potenz der Winkelfunktion]
$ sin^2 x=1/2(1-cos 2x), quad cos^2 x=1/2(1+cos 2x) $
$ sin^3 x=sin x(1-cos^2 x), quad cos^3 x=cos x(1-sin^2 x) $
$ sin^4 x=3/8-1/2 cos 2x+1/8 cos 4x $
$ cos^4 x=3/8+1/2 cos 2x+1/8 cos 4x $

#sub[Reduktionsformel]
$ integral cos^n x dif x = (n-1)/n integral cos^(n-2)x dif x + (cos^(n-1)x sin x)/n $
$ integral sin^n x dif x = (n-1)/n integral sin^(n-2)x dif x - (cos x sin^(n-1)x)/n $

#sub[Wallis'sche Integrale]
$ W_n = integral_0^(pi/2) sin^n x dif x = integral_0^(pi/2) cos^n x dif x $
Rekursion (aus Reduktionsformel): $W_n = (n-1)/n W_(n-2)$, $W_0=pi/2$, $W_1=1$.
$ W_(2n) = ((2n-1)!!)/((2n)!!) dot pi/2, quad W_(2n+1) = ((2n)!!)/((2n+1)!!) $
$(W_n)$ ist streng monoton fallend, $W_n>0$, und $W_n W_(n-1)=pi/(2n)$.

$W_n dot W_(n+1) = pi/(2(n+1))$; asymptotisch $W_n tilde sqrt(pi/(2n))$, $lim_(n->oo) W_(n+1)/W_n=1$.

#B *(Wallis-Produkt)* $ pi/2 = product_(n=1)^oo (2n)/(2n-1) dot (2n)/(2n+1) = 2/1 dot 2/3 dot 4/3 dot 4/5 dot 6/5 dots $

#sub[Bogenlänge]
$ L=integral_a^b sqrt(1+(f'(x))^2) dif x $

#sub[(Un)gerade Funktionen]
$f$ *gerade*: $f(-x)=f(x)$; *ungerade*: $f(-x)=-f(x)$.

#sub[Bekannte Taylorreihen]
$ e^x=1+x+x^2/2+x^3/3!+dots=sum_(k=0)^oo x^k/k! $
$ sin x=x-x^3/3!+x^5/5!-dots=sum_(k=0)^oo (-1)^k x^(2k+1)/(2k+1)! $
$ sinh x=x+x^3/3!+x^5/5!+dots=sum_(k=0)^oo x^(2k+1)/(2k+1)! $
$ cos x=1-x^2/2+x^4/4!-dots=sum_(k=0)^oo (-1)^k x^(2k)/(2k)! $
$ cosh x=1+x^2/2+x^4/4!+dots=sum_(k=0)^oo x^(2k)/(2k)! $
$ tan x=x+x^3/3+(2x^5)/15+dots $
$ tanh x=x-x^3/3+(2x^5)/15-dots $
$ log(1+x)=x-x^2/2+x^3/3-dots=sum_(k=1)^oo (-1)^(k-1) x^k/k $
$ (1+x)^alpha=1+alpha x+(alpha(alpha-1))/2! x^2+dots=sum_(k=0)^oo binom(alpha, k) x^k $
$ sqrt(1+x)=1+x/2-x^2/8+x^3/16-(5x^4)/128+(7x^5)/256-dots $

#chapter[Typische Grenzwerte / Folgen]
#table(
  columns: (1fr, 1fr),
  stroke: innergrid,
  inset: (x: 4pt, y: 4.5pt),
  align: horizon,
  $lim_(x->oo) 1/x=0$, $lim_(x->oo)(1+1/x)=1$,
  $lim_(x->oo) e^x=oo$, $lim_(x->-oo) e^(-x)=oo$,
  $lim_(x->-oo) e^x=0$, $lim_(x->oo) x e^(-x)=0$,
  $lim_(x->oo) e^x/x^m=oo$, $lim_(x->0^+) ln x=-oo$,
  $lim_(x->oo) ln x=oo$, $lim_(x->0)(1+x)^(1/x)=e$,
  $lim_(x->oo)(1+x)^(1/x)=1$, $lim_(x->oo)(1-1/x)^x=1/e$,
  $lim_(x->oo) x^a q^x=0\, med 0<=q<1$, $lim_(x->0)(sin x)/x=1$,
  $lim_(x->plus.minus oo)(1+1/x)^x=e$, $lim_(x->0)(cos x-1)/x=0$,
  $lim_(x->oo)(1+k/x)^(m x)=e^(k m)$, $lim_(x->0) x log x=0$,
  $lim_(x->0) 1/(cos x)=1$, $lim_(x->0)(e^x-1)/x=1$,
  $lim_(x->0)(1-cos x)/x^2=1/2$, $lim_(x->oo) arctan x=pi/2$,
  $lim_(x->0) x/(arctan x)=1$, $lim_(x->0)(e^(a x)-1)/x=a$,
  $lim_(x->oo)(x/(x+k))^x=e^(-k)$, $lim_(x->1)(ln x)/(x-1)=1$,
  $lim_(x->0)(a^x-1)/x=ln a$, $lim_(x->oo)(log x)/x^a=0$,
  $lim_(x->0)(ln(x+1))/x=1$, $lim_(x->oo)(2^x)/x^2=oo$,
  $lim_(x->oo)(ln x)/x=0$, $lim_(x->pi/2^+) tan x=-oo$,
  $lim_(x->oo) root(x, x)=1$, $lim_(x->0^+) x ln x=0$,
  $lim_(x->pi/2^-) tan x=+oo$, $lim_(x->oo)(sin x)/x=0$,
)

#sub[Typische Reihen]
#table(
  columns: (1fr, 1fr),
  stroke: innergrid,
  inset: (x: 4pt, y: 4.5pt),
  align: horizon,
  $sum_(i=1)^n i=(n(n+1))/2$, $sum_(i=1)^n i^2=(n(n+1)(2n+1))/6$,
  $sum_(i=1)^n i^3=(n^2(n+1)^2)/4$, $sum_(n=1)^oo 1/n^2=pi^2/6$,
  $sum_(n=1)^oo 1/(n(n+1))=1$,
)

*Geometrisch:* $sum_(k=0)^n q^k=(1-q^(n+1))/(1-q)$; für $|q|<1$: $sum_(k=0)^oo q^k=1/(1-q)$. \
*$p$-Reihe / Zeta:* $zeta(p)=sum_(n=1)^oo 1/n^p$ konv. für $p>1$, div. für $p<=1$. \
*Alternierend harmonisch:* $sum_(n=1)^oo (-1)^(n+1)/n$ konv. \
*Teleskop:* $sum log(n/(n+1))=-oo$.

#chapter[Ableitungen & Stammfunktionen]
#set text(size: 7pt)
#table(
  columns: (1fr, 1fr),
  inset: (x: 4pt, y: 6pt),
  align: center + horizon,
  stroke: innergrid,
  table.header(
    repeat: false,
    $F(x)$, $F'(x)=f(x)$,
  ),
  $c$, $0$,
  $x^a$, $a x^(a-1)$,
  $1/(a+1)x^(a+1)$, $x^a$,
  $(x^(alpha+1))/(alpha+1)$, $x^alpha, alpha eq.not -1$,
  $sqrt(x)$, $1/(2sqrt(x))$,
  $root(n, x)$, $1/n x^(1/n-1)$,
  $2/3 x^(3/2)$, $sqrt(x)$,
  $e^x$, $e^x$,
  $ln|x|$, $1/x$,
  $log_a|x|$, $1/(x ln a)$,
  $sin x$, $cos x$,
  $cos x$, $-sin x$,
  $tan x$, $1/(cos^2 x)=1+tan^2 x$,
  $cot x$, $-1/(sin^2 x)$,
  $arcsin x$, $1/sqrt(1-x^2)$,
  $arccos x$, $-1/sqrt(1-x^2)$,
  $arctan x$, $1/(1+x^2)$,
  $sinh x$, $cosh x$,
  $cosh x$, $sinh x$,
  $tanh x$, $1/(cosh^2 x)=1-tanh^2 x$,
  $"arcsinh" x$, $1/sqrt(1+x^2)$,
  $"arccosh" x$, $1/sqrt(x^2-1)$,
  $"arctanh" x$, $1/(1-x^2)$,
  $1/f(x)$, $-f'(x)/(f(x))^2$,
  $a^(c x)$, $a^(c x) c ln a$,
  $x^x$, $x^x(1+ln x)$,
  $1/a ln(a x+b)$, $1/(a x+b)$,
  $1/(2a)ln|(x-a)/(x+a)|$, $1/(x^2-a^2)$,
  $x/2 sqrt(a^2+x^2)+a^2/2 ln(x+sqrt(a^2+x^2))$, $sqrt(a^2+x^2)$,
  $x/2 sqrt(a^2-x^2)+a^2/2 arcsin(x/|a|)$, $sqrt(a^2-x^2)$,
  $x/2 sqrt(x^2-a^2)-a^2/2 ln(x+sqrt(x^2-a^2))$, $sqrt(x^2-a^2)$,
  $ln(x+sqrt(x^2 plus.minus a^2))$, $1/sqrt(x^2 plus.minus a^2)$,
  $1/a arctan(x/a)$, $1/(x^2+a^2)$,
  $-1/a cos(a x+b)$, $sin(a x+b)$,
  $1/a sin(a x+b)$, $cos(a x+b)$,
  $-ln|cos x|$, $tan x$,
  $ln|sin x|$, $cot x$,
  $ln|tan(x/2)|$, $1/(sin x)$,
  $ln|tan(x/2+pi/4)|$, $1/(cos x)$,
  $1/2(x-sin x cos x)$, $sin^2 x$,
  $1/2(x+sin x cos x)$, $cos^2 x$,
  $tan x-x$, $tan^2 x$,
  $-cot x-x$, $cot^2 x$,
  $x arcsin x+sqrt(1-x^2)$, $arcsin x$,
  $x arccos x-sqrt(1-x^2)$, $arccos x$,
  $x arctan x-1/2 ln(1+x^2)$, $arctan x$,
  $ln(cosh x)$, $tanh x$,
  $ln|f(x)|$, $f'(x)/f(x)$,
  $x(ln|x|-1)$, $ln|x|$,
  $(e^(c x)(c sin(a x+b)-a cos(a x+b)))/(a^2+c^2)$, $e^(c x)sin(a x+b)$,
  $(e^(c x)(c cos(a x+b)+a sin(a x+b)))/(a^2+c^2)$, $e^(c x)cos(a x+b)$,
)
#set text(size: 7.4pt)

#chapter[Differentialgleichungen]
#D Eine *(gewöhnliche) DGL (ODE)* der Ordnung $n$: $F(u(t),u'(t),dots,u^((n))(t),t)=0$.

$t$: unabhängige, $u$: abhängige Variable.

*Lineare DG:* $a_(n)(x)y^((n))+dots+a_(1)(x)y'+a_(0)(x)y=s(x)$.

$s equiv 0$: homogen, sonst inhomogen. Ordnung = höchste Ableitung.

*Zwei Problemarten:* Randwertproblem (Info an $n$ Punkten); Anfangswertproblem (Info an einem Punkt: $u(t_0)=u_0, u'(t_0)=v_0,dots$).

#sub[Lineare homogene DG, konstante Koeffizienten]
$a_n u^((n))+dots+a_1 u'+a_0 u=0$. Euler-Ansatz $u(x)=e^(lambda x)$.
*Charakteristisches Polynom:* $p(lambda)=a_n lambda^n+dots+a_1 lambda+a_0=0$.
Nullstellen mit Vielfachheit $m$ liefern $m$ Fundamentallösungen:
+ reell einfach $lambda$: $e^(lambda x)$
+ reell $m$-fach: $e^(lambda x), x e^(lambda x),dots,x^(m-1)e^(lambda x)$
+ Paar $alpha plus.minus i beta$ einfach: $e^(alpha x)cos(beta x), e^(alpha x)sin(beta x)$
+ Paar $alpha plus.minus i beta$ $m$-fach ($k=0,dots,m-1$): $x^k e^(alpha x)cos(beta x), x^k e^(alpha x)sin(beta x)$ (also $2m$ Fundamentallösungen)

*Allgemeine Lösung:* Summe aller Fundamentallösungen, jeweils mal Konstante: $y(x)=C_1 y_(1)(x)+dots+C_n y_(n)(x)$.

#sub[Superpositionsprinzip]
Lösungen $y_1,y_2$ linearer homogener DG $=> y=C_1 y_1+C_2 y_2$ Lösung.

#sub[Lineare inhomogene DG, konst. Koeff.]
$y(x)=y_(h)(x)+y_(p)(x)$.

Erst $y_h$ (homogen) finden, dann Ansatz für $y_p$ nach Störterm $s(x)$:

#table(
  columns: (1fr, 1.15fr),
  stroke: innergrid,
  inset: (x: 4pt, y: 4.5pt),
  align: horizon,
  table.header(
    repeat: false,
    [*Störterm $s(x)$*], [*Ansatz $y_p$*],
  ),
  $a_0+a_1 u+dots+a_n u^n$, $(C_0+dots+C_n u^n)u^m$,
  $e^(k u)$, $C e^(k u) dot u^m$,
  $A sin(w u)+B cos(w u)$, $(C_1 sin(w u)+C_2 cos(w u))u^m$,
)

*Resonanz – Exponent $m$ bestimmen:* Zu jedem Störterm gehört eine Testzahl $lambda$:
- Polynom: $lambda=0$
- $e^(k u)$: $lambda=k$
- $sin\/cos(w u)$: $lambda=i w$

$m=$ wie oft $lambda$ Nullstelle des char. Polynoms ist. Ist $lambda$ keine Nullstelle $=>$ keine Resonanz, $m=0$ (Faktor $u^m=1$ fällt weg).

Dann Koeffizienten $C_i$ finden: $y_p$ ableiten, in DG einsetzen, Koeffizientenvergleich.

#sub[Existenz & Eindeutigkeit (Picard)]
#bx[
  #S Ist $f$ stetig & Lipschitz-stetig in der 2. Variablen ($exists L>0: |f(x,y_1)-f(x,y_2)|<=L|y_1-y_2|$), so hat das AWP $cases(u'=f(x,u), u(x_0)=y_0)$ eine eindeutige $C^1$-Lösung.
]

#strat[Strategie – DGL 1. Ordnung]
Form erkennen $->$ passende Methode:

#table(
  columns: (auto, auto, 1fr),
  stroke: innergrid,
  inset: (x: 4pt, y: 4.5pt),
  align: horizon,
  table.header(
    repeat: false,
    [*Form*], [*Methode*], [*Ansatz \/ Substitution*],
  ),
  $y'=f(x)g(y)$, [TrennVar], $integral (dif y)/(g(y))=integral f(x)dif x$,
  $y'=g(y\/x)$, [Homogen], [$z=y\/x: med x z'=g(z)-z$ (trennbar)],
  $y'=f(a x+b y+c)$, [LinSub], $z=a x+b y+c$,
  $y'+f(x)y=g(x)$, [VarKonst], $y=C(x)e^(-F(x)), med F'=f$,
  $M dif x+N dif y=0$, [Exakt], $M_y=N_x; med F_x=M, F_y=N$,
)

*Grundregeln für 1. Ordnung:*
- $y'=f(x)g(y)$: Variablen trennen.
- $y'=g(y\/x)$ (homogen, rechte Seite hängt nur von $y\/x$ ab):
  $z=y\/x$ substituieren $->$ trennbar.
- $y'+p(x)y=q(x)$: integrierender Faktor oder Variation der Konstanten.
- Lineare DGL mit konstanten Koeffizienten: charakteristisches Polynom.
- Inhomogene DGL: $y=y_h+y_p$.
- Anfangsbedingungen erst in die vollständige Lösung einsetzen.

*Trennung der Variablen:* $y'=f(x)g(y)$:
#steps[
  + $1/(g(y))dif y=f(x)dif x$
  + beide Seiten integrieren
  + nach $y$ umformen
]

*Substitution:*
#steps[
  + neue Grösse $z$ einführen
  + $z$ nach $x$ ableiten $->$ trennbare DGL
  + mit TrennVar lösen
  + Rücksubstitution
]

*Variation der Konstanten* ($y' + f(x)y = g(x)$):

Sei $F(x) = integral f(x) dif x$. Dann ist die allgemeine Lösung der homogenen Gleichung

$ y_(h)(x) = A e^(-F(x)). $

#steps[
  + Ersetze die Konstante $A$ durch eine Funktion $C(x)$:

    $ y_(p)(x) = C(x)e^(-F(x)). $

  + Ableiten und Einsetzen in $y' + f(x)y = g(x)$ ergibt:

    $ C'(x)e^(-F(x)) = g(x). $

  + Somit gilt:

    $ C'(x) = g(x)e^(F(x)). $

  + Integrieren:

    $ C(x) = C_0 + integral g(x)e^(F(x)) dif x. $
]

#bx[
  #S Die allgemeine Lösung von $y' + f(x)y = g(x)$ ist

  $ y(x) = e^(-F(x)) lr((C_0 + integral g(x)e^(F(x)) dif x)), quad F'(x) = f(x). $
]

#sub[Wichtige Funktionen im Überblick]
#figure(image("functions.png", width: 100%))

#chapter[Task Examples]

#sub[Komplexe Nullstelle]
$P(x)=x^3-x^2+x+1+a$ und $P(-i)=0$:
$ 0=P(-i)=i+1-i+1+a=a+2 => a=-2. $
$ P(x)=x^3-x^2+x-1=(x-1)(x^2+1)=(x-1)(x-i)(x+i). $

#block(width: 100%, breakable: false)[
  #sub[Konvergenz mit der $epsilon$-Definition]
  *Aufgabe:* Zeige $a_n=1/n -> 0$.

  Sei $epsilon>0$. Wähle $N in NN$ mit $N>1/epsilon$. Dann gilt für alle $n>=N$:
  $ |a_n-0|=1/n<=1/N<epsilon. $
  Also $a_n -> 0$.
]

#block(width: 100%, breakable: false)[
  #sub[Monotone Konvergenz]
  *Aufgabe:* Zeige $lim_(n->oo) a^n/(n!) = 0$ für $a>0$.

  Setze $b_n=a^n/n!$. Für $n+1>a$ gilt
  $ b_(n+1)/b_n=a/(n+1)<1. $
  Also ist $(b_n)$ schliesslich fallend und durch $0$ nach unten beschränkt, somit $b_n->L$. Da $(b_n)$ beschränkt ist,
  $ L=lim b_(n+1)=lim a/(n+1) b_n=0. $
]

#block(width: 100%, breakable: false)[
  #sub[Cauchy-Folge]
  *Aufgabe:* Sei $(s_n)_(n>=0)$ eine Cauchy-Folge, $k>0$ und
  $ |t_n-t_m|<=k|s_n-s_m| quad forall n,m>=1. $
  Zeige, dass $(t_n)_(n>=0)$ ebenfalls eine Cauchy-Folge ist.

  Sei $epsilon>0$. Da $(s_n)$ Cauchy ist, gibt es ein $N$ mit
  $ |s_n-s_m|<epsilon/k quad forall n,m>=N. $
  Dann gilt
  $ |t_n-t_m|<=k|s_n-s_m|<k dot epsilon/k=epsilon. $
  Also ist $(t_n)$ eine Cauchy-Folge.
]

#chapter[Algebraic Tricks]

#sub[Polynome und Brüche]
- *Ausklammern:* $a x+a y=a(x+y)$; nach gemeinsamen Faktoren oder Potenzen suchen.
- *Binome:* $(a plus.minus b)^2=a^2 plus.minus 2a b+b^2$, $quad a^2-b^2=(a-b)(a+b)$.
- *Kubiken:* $a^3-b^3=(a-b)(a^2+a b+b^2)$, $quad a^3+b^3=(a+b)(a^2-a b+b^2)$.
- *Quadratisch ergänzen:* $x^2+b x+c=(x+b/2)^2+c-b^2/4$.
- *Substitution:* nur $x^2,x^4,dots$ vorhanden $=> u=x^2$; wiederholten Ausdruck $g(x)$ durch $u$ ersetzen.
- *Brüche:* $A/B plus.minus C/D=(A D plus.minus B C)/(B D)$; vor dem Kürzen faktorisieren.
#block(width: 100%, breakable: false)[
  - *Partialbruch bei konstantem Abstand:* Ist $B-A=c != 0$, dann
    $ 1/(A B)=1/c dot (1/A-1/B). $
    Beispiel: $1/((3v-2)(3v+1))=1/3 dot (1/(3v-2)-1/(3v+1))$.
]
- Falls $deg P>=deg Q$: $P/Q=S+R/Q$ mit $deg R<deg Q$ (Polynomdivision).
- Bei $x->oo$: Zähler und Nenner durch die höchste vorkommende Potenz von $x$ teilen.

#sub[Potenzen und Wurzeln]
- $a^m a^n=a^(m+n)$, $a^m/a^n=a^(m-n)$, $(a^m)^n=a^(m n)$, $a^(-n)=1/a^n$.
- Für $a,b>=0$: $sqrt(a b)=sqrt(a)sqrt(b)$; immer $sqrt(a^2)=|a|$.
- *Konjugiert erweitern:*
  $ sqrt(A)-sqrt(B)=(A-B)/(sqrt(A)+sqrt(B)) $
- Unter Wurzeln höchste Potenz ausklammern:
  $sqrt(x^2 A)=|x|sqrt(A)$.
- Bruchpotenzen: $root(n, a^m)=a^(m/n)$ (Definitionsbereich beachten).

#sub[Exponential- und Logarithmusformen]
- $a^x=e^(x ln a)$ für $a>0$; allgemein $f(x)^(g(x))=e^(g(x) ln f(x))$ für $f(x)>0$.
- $e^u e^v=e^(u+v)$, $e^u/e^v=e^(u-v)$, $e^u-e^v=e^v(e^(u-v)-1)$.
- $ln(a b)=ln a+ln b$, $ln(a/b)=ln a-ln b$, $ln(a^r)=r ln a$ ($a,b>0$).
- Gleichungen: $e^u=e^v <=> u=v$; $ln u=ln v <=> u=v$ bei $u,v>0$.
- Produkte und Potenzen im Logarithmus werden zu Summen und Faktoren; das vereinfacht Ableitungen und Grenzwerte.

#sub[Trigonometrische Umformungen]
- $sin^2 x+cos^2 x=1$, $quad tan x=sin x/cos x$.
- $1-cos x=2sin^2(x/2)$, $quad 1+cos x=2cos^2(x/2)$.
- $sin x=2sin(x/2)cos(x/2)$, $quad sin(2x)=2sin x cos x$.
- $cos(2x)=cos^2 x-sin^2 x=1-2sin^2 x=2cos^2 x-1$.
- *Produkt $->$ Summe:*
  $2sin a cos b=sin(a+b)+sin(a-b)$,
  $2cos a cos b=cos(a+b)+cos(a-b)$.
- *Halbwinkelsubstitution* $t=tan(x/2)$:
  $sin x=(2t)/(1+t^2)$, $cos x=(1-t^2)/(1+t^2)$.

#sub[Betrag, Gleichungen und Kontrolle]
- $|u|=cases(u & u>=0, -u & u<0)$ und $sqrt(u^2)=|u|$.
- Für $c>=0$: $|u|=c <=> u=plus.minus c$; $|u|<c <=> -c<u<c$.
- Nenner beseitigen: mit dem Hauptnenner multiplizieren, aber ausgeschlossene Nullstellen notieren.
- Wurzelgleichung: Wurzel isolieren, quadrieren, lösen und *jede Lösung einsetzen* (Scheinlösungen möglich).
- Definitionsbereich zuerst: Nenner $eq.not 0$, Log-Argument $>0$, gerade Wurzel mit Radikand $>=0$.
