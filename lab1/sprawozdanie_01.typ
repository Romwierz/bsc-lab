#set document(
  title: [BSC Sprawozdanie - Laboratorium 1: Modelowanie układów cyfrowych],
  author: "Michał Romsicki"
)

#set page(
  numbering: "1"
)

#set heading(
  numbering: "1."
)

#let title-table(subject, topic, name1, name2, album_nr1, album_nr2) = [
  #table(
    columns: (1fr, 1fr),
    fill: (_, y) =>
      if y == 0 { rgb("b6bab7") }
      else if y == 2 { rgb("d5dbd7") },
    inset: (x, y) =>
        if y == 0 { 10pt }
        else if y == 1 { 8pt }
        else { 6pt },
    // stroke: 1pt + black,
    align: (center),
    table.cell(
      colspan: 2,
      text(size: 16pt)[
        *#subject*
      ],
    ),
    table.cell(
      colspan: 2,
      text(size: 12pt)[
        #topic
      ],
    ),
    text(size: 12pt)[
      Imię i nazwisko
    ],
    text(size: 12pt)[
      Nr albumu
    ],
    text(size: 10pt)[
      #name1
    ],
    text(size: 10pt)[
      #album_nr1
    ],
    text(size: 10pt)[
      #name2
    ],
    text(size: 10pt)[
      #album_nr2
    ],
  )
]

#show heading.where( level: 1 ): it => block(width: 100%)[
  #set align(left)
  #set text(14pt, weight: "bold")
  #it
  #v(0.4em)
]

#show heading.where( level: 2 ): it => block(width: 100%)[
  #set align(left)
  #set text(12pt, weight: "bold")
  #it
  #v(0.4em)
]

#let heading0(body) = block(width: 100%)[
  #set align(left)
  #set text(14pt, weight: "bold")
  #v(0.4em)
  0. #body
]

#show raw.where(block: true): it => [
  #set text(size: 7pt)
  #it
]

#show par: set text(size: 11pt)

#let img-border-style = stroke(thickness: 0.3pt, paint: gray)

#title-table(
  "Bezpiecznie systemy cyfrowe",
  "Laboratorium 1: Modelowanie układów cyfrowych",
  "Bajo Jajo", "Bajo Jajo",
  "xxxxxx", "xxxxxx"
)

#text(10pt, weight: "bold")[
  Oryginalny kod z pliku `max5.v`:
]
```verilog
module max5  (clk, d1, d2, d3, d4, d5, wy);
input  clk;
input   [3:0] d1, d2, d3, d4, d5;
output  [3:0] wy;

reg [3:0] wy,  r1, r2, r3, r4, r5, max12, max34, max1234, max;

always @(posedge clk)
begin
    r1 <= d1;
    r2 <= d2;
    r3 <= d3;
    r4 <= d4;
    r5 <= d5;
end

///////////////
always @(r1, r2)
    if ( r1 > r2) 
        max12 <= r1;
    else
        max12 <= r2;

always @(r3, r4)
    if ( r3 > r4) 
        max34 <= r3;
    else
        max34 <= r4;
		
///////////////
always @(max12, max34)
    if ( max12 > max34) 
        max1234 <= max12;
    else
        max1234 <= max34;

///////////////
always @(max1234, r5)
    if ( max1234 > r5) 
        max <= max1234;
    else
        max <= r5;

always @(posedge clk) wy <= max;

endmodule
```

#block(breakable: false)[
#text(10pt, weight: "bold")[
  Zmodyfikowany kod implementujący potokowanie:
]
```verilog
module max5p (clk, d1, d2, d3, d4, d5, wy);
input  clk;
input  [3:0] d1, d2, d3, d4, d5;
output [3:0] wy;

reg [3:0] wy,  r1, r2, r3, r4, r5, r5del, max12, max12del, max34, max34del, max1234, max;

always @(posedge clk)
begin
    r1 <= d1;
    r2 <= d2;
    r3 <= d3;
    r4 <= d4;
    r5 <= d5;
end

always @(posedge clk)
begin
	r5del <= r5;
end

///////////////
always @(r1, r2)
    if (r1 > r2) 
        max12 <= r1;
    else
        max12 <= r2;

always @(r3, r4)
    if (r3 > r4) 
        max34 <= r3;
    else
        max34 <= r4;
		
///////////////
always @(max12, max34)
    if (max12 > max34) 
        max1234 <= max12;
    else
        max1234 <= max34;

///////////////
always @(max1234, r5del)
    if ( max1234 > r5del) 
        max <= max1234;
    else
        max <= r5del;

always @(posedge clk) wy <= max;

endmodule
```
]

#block(breakable: false)[
  #text(10pt, weight: "bold")[
    Zobrazowanie wyników symulacji:
  ]
  #rect(inset: 0pt, width: 100%, stroke: img-border-style, image("images/pasted_20260315_222810.png"))
]
