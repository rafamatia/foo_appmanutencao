unit uRotinas;

interface

uses
  SysUtils;

function retornarTempoPorExtenso(ATempo: Extended): String;

implementation

function retornarTempoPorExtenso(ATempo: Extended): String;
var
  intHora, intMin, intSeg: integer;
begin
  intHora := Trunc(ATempo / 3600000);
  intMin := Trunc((ATempo / 3600000 - intHora) * 60);
  intSeg := Trunc(((((ATempo / 3600000 - intHora) * 60) - intMin) * 60));
  result := Format('%.2d:%.2d:%.2d', [intHora, intMin, intSeg]);
end;

end.
