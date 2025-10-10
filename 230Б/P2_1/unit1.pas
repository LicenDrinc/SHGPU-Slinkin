unit Unit1;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils;

type
    RGB = record
        r: byte;
        g: byte;
        b: byte;
    end;

    transform = record
        x: integer;
        y: integer;
    end;

    TXCanvas = class
        public
            image: array of array of RGB;

            constructor Create();

            procedure fileLoad(nameFile: string);
            procedure fileSave(nameFile: string);
            procedure changingTransform(x, y: integer);
            procedure changingColorPencil(r, g, b: byte);
            procedure changingTransformPencil(x, y: integer);
            procedure changingSizePencil(x, y: integer);
            procedure paint();
            procedure rectanglePaint(xSize, ySize: integer);
            procedure fillRectanglePaint(xSize, ySize: integer);
            procedure linePaint(xSize, ySize: integer);
            procedure filling();
            procedure overlayImage(image1: TXCanvas);

            function gettingTransform(): transform;
            function gettingColorPencil(): RGB;
            function gettingTransformPencil(): transform;
            function gettingSizePencil(): transform;
        private
            fileImage: text;
            transformImage: transform;
            transformPencil: transform;
            sizePencil: transform;
            colorPencil: RGB;
            colorTransformPencil: RGB;

            procedure imageToFile();
            procedure fileToImage();
            procedure fillRecursion(x, y: integer);
    end;

implementation

constructor TXCanvas.Create();
begin
    inherited Create;
    transformImage.x:=0;
    transformImage.y:=0;
    transformPencil.x:=0;
    transformPencil.y:=0;
    sizePencil.x:=0;
    sizePencil.y:=0;
    colorPencil.r:=0;
    colorPencil.g:=0;
    colorPencil.b:=0;
end;

procedure TXCanvas.imageToFile();
var
    str, str1, str2, str3: string;
    x, y: integer;
begin
    x := 0; y:= 0;
    writeln(fileImage, 'P3');
    writeln(fileImage, IntToStr(transformImage.x) + ' ' + IntToStr(transformImage.y));
    writeln(fileImage, '255');
    while true do
    begin
        if (y > transformImage.y-1) then
            break;
        str1 := IntToStr(image[y][x].r);
        str2 := IntToStr(image[y][x].g);
        str3 := IntToStr(image[y][x].b);
        str := str1 + ' ' + str2 + ' ' + str3;
        if (x >= transformImage.x-1) then
        begin
            y := y + 1; x := 0;
        end
        else
            x := x + 1;
        writeln(fileImage, str);
    end;
end;
procedure TXCanvas.fileToImage();
var
    str, str1, str2, str3: string;
    checkP3: boolean = false;
    checkColor: boolean = false;
    len1, len2, i, x, y: integer;
begin
    x := 0; y:= 0;
    while not Eof(fileImage) do
    begin
        readln(fileImage,str);
        if (str[1] = '#') then
        begin
            continue;
        end
        else if (str = 'P3') then
        begin
            checkP3 := true;
            continue;
        end
        else
        begin
            str1 := str; str2 := str;
            if (checkP3) then
            begin
                checkP3 := false;
                len1 := pos(' ',str1);
                Delete(str1,len1,length(str1));
                Delete(str2,1,len1);
                transformImage.x := StrToInt(str1);
                transformImage.y := StrToInt(str2);
                setLength(image,transformImage.y);
                for i := 0 to transformImage.y-1 do
                    setLength(image[i],transformImage.x);
            end
            else if not (checkColor) then
            begin
                checkColor := true;
                continue;
            end
            else
            begin
                if (y > transformImage.y-1) then
                    continue;
                len1 := pos(' ',str1);
                Delete(str1,len1,length(str1));
                Delete(str2,1,len1);
                len2 := pos(' ',str2);
                str3 := str2;
                Delete(str2,len2,length(str2));
                Delete(str3,1,len2);
                image[y][x].r := byte(StrToInt(str1));
                image[y][x].g := byte(StrToInt(str2));
                image[y][x].b := byte(StrToInt(str3));
                if (x >= transformImage.x-1) then
                begin
                    y := y + 1; x := 0;
                end
                else
                    x := x + 1;
            end;
        end;
    end;
end;

procedure TXCanvas.fileLoad(nameFile: string);
begin
    assign(fileImage, nameFile);
    reset(fileImage);
    fileToImage();
    close(fileImage);
end;
procedure TXCanvas.fileSave(nameFile: string);
begin
    assign(fileImage, nameFile);
    rewrite(fileImage);
    imageToFile();
    close(fileImage);
end;

procedure TXCanvas.changingTransform(x, y: integer);
var
    i, j: integer;
    transformOld: transform;
begin
    transformOld.x := transformImage.x;
    transformOld.y := transformImage.y;
    transformImage.x := x;
    transformImage.y := y;
    setLength(image,transformImage.y);
    for i := 0 to transformImage.y-1 do
    begin
        setLength(image[i],transformImage.x);
        for j := 0 to transformImage.x-1 do
        begin
            if (transformOld.y-1 < i) or (transformOld.x-1 < j) then
            begin
                image[i][j].r := 255;
                image[i][j].g := 255;
                image[i][j].b := 255;
            end;
        end;
    end;
end;
function TXCanvas.gettingTransform(): transform;
begin
    result := transformImage;
end;

procedure TXCanvas.changingColorPencil(r, g, b: byte);
begin
    colorPencil.r := r;
    colorPencil.g := g;
    colorPencil.b := b;
end;
function TXCanvas.gettingColorPencil(): RGB;
begin
    result := colorPencil;
end;

procedure TXCanvas.changingTransformPencil(x, y: integer);
begin
    transformPencil.x := x;
    transformPencil.y := y;
end;
function TXCanvas.gettingTransformPencil(): transform;
begin
    result := transformPencil;
end;

procedure TXCanvas.changingSizePencil(x, y: integer);
begin
    sizePencil.x := x;
    sizePencil.y := y;
end;
function TXCanvas.gettingSizePencil(): transform;
begin
    result := sizePencil;
end;

procedure TXCanvas.paint();
var
    i, j: integer;
    i1, i2, j1, j2: integer;
begin
    i1 := transformPencil.y;
    i2 := sizePencil.y + transformPencil.y;
    j1 := transformPencil.x;
    j2 := sizePencil.x + transformPencil.x;
    if (i1 - i2 > 0) then
    begin
        i2 := transformPencil.y;
        i1 := sizePencil.y + transformPencil.y;
    end;
    if (j1 - j2 > 0) then
    begin
        j2 := transformPencil.x;
        j1 := sizePencil.x + transformPencil.x;
    end;
    for i := i1 to i2 do
    begin
        for j := j1 to j2 do
        begin
            if (i <= transformImage.y-1) and (i >= 0) and (j <= transformImage.x-1) and (j >= 0) then
            begin
                image[i][j].r := colorPencil.r;
                image[i][j].g := colorPencil.g;
                image[i][j].b := colorPencil.b;
            end;
        end;
    end;
end;

procedure TXCanvas.rectanglePaint(xSize, ySize: integer);
var
    i, j: integer;
    i1, i2, j1, j2: integer;
    xStart, yStart: integer;
    xEnd, yEnd: integer;
begin
    xStart := transformPencil.x;
    yStart := transformPencil.y;
    xEnd := xStart + xSize;
    yEnd := yStart + ySize;
    i1 := yStart; i2 := yEnd;
    j1 := xStart; j2 := xEnd;
    if (i1 - i2 >= 0) then
    begin
        i2 := yStart; i1 := yEnd;
    end;
    if (j1 - j2 >= 0) then
    begin
        j2 := xStart; j1 := xEnd;
    end;
    for i := i1 to i2 do
    begin
        changingTransformPencil(xStart,i);
        paint();
        changingTransformPencil(xEnd,i);
        paint();

    end;
    for j := j1 to j2 do
    begin
        changingTransformPencil(j,yStart);
        paint();
        changingTransformPencil(j,yEnd);
        paint();

    end;
end;

procedure TXCanvas.fillRectanglePaint(xSize, ySize: integer);
var sizePencilOld: transform;
begin
    sizePencilOld := sizePencil;
    changingSizePencil(xSize, ySize);
    paint();
    changingSizePencil(sizePencilOld.x, sizePencilOld.y);
end;

procedure TXCanvas.linePaint(xSize, ySize: integer);
var
    j, j1, j2, i, i1, i2: integer;
    y, x, d1, d2: real;
    xStart, yStart: integer;
    xEnd, yEnd: integer;
begin
    xStart := transformPencil.x;
    yStart := transformPencil.y;
    xEnd := xStart + xSize;
    yEnd := yStart + ySize;
    i1 := yStart; i2 := yEnd;
    j1 := xStart; j2 := xEnd;
    {
    if (i1 - i2 > 0) then
    begin
        i2 := yStart; i1 := yEnd;
    end;
    if (j1 - j2 > 0) then
    begin
        j2 := xStart; j1 := xEnd;
    end;
    }
    if (abs(xSize) > abs(ySize)) then
    begin
        d1 := (ySize) / (xSize * 1.0);
        if (j1 - j2 > 0) then
        begin
            for j := j1 downto j2 do
            begin
                y := d1 * (j - xStart) + yStart;
                changingTransformPencil(j,Round(y));
                paint();
            end;
        end
        else
        begin
            for j := j1 to j2 do
            begin
                y := d1 * (j - xStart) + yStart;
                changingTransformPencil(j,Round(y));
                paint();
            end;
        end;
    end
    else
    begin
        d2 := (xSize * 1.0) / (ySize);
        if (i1 - i2 > 0) then
        begin
            for i := i1 downto i2 do
            begin
                x := d2 * (i - yStart) + xStart;
                changingTransformPencil(Round(x),i);
                paint();
            end;
        end
        else
        begin
            for i := i1 to i2 do
            begin
                x := d2 * (i - yStart) + xStart;
                changingTransformPencil(Round(x),i);
                paint();
            end;
        end;
    end;
end;

procedure TXCanvas.fillRecursion(x, y: integer);
var transformPencilOld: transform;
    left, right, i: integer;
begin
    if (x >= 0) and (x < transformImage.x) and (y >= 0) and (y < transformImage.y) and (image[y][x].r = colorTransformPencil.r) and (image[y][x].b = colorTransformPencil.b) and (image[y][x].g = colorTransformPencil.g) then
    begin
      transformPencilOld := transformPencil;
      left := 0; right := transformImage.x;
      for i := x to right do
      begin
          if (image[y][i].r = colorTransformPencil.r) and (image[y][i].b = colorTransformPencil.b) and (image[y][i].g = colorTransformPencil.g) then
          begin
              changingTransformPencil(i, y);
              paint();
          end
          else
          begin
             right := i - 1;
             break;
          end;
      end;
      for i := x - 1 downto left do
      begin
          if (image[y][i].r = colorTransformPencil.r) and (image[y][i].b = colorTransformPencil.b) and (image[y][i].g = colorTransformPencil.g) then
          begin
              changingTransformPencil(i, y);
              paint();
          end
          else
          begin
             left := i + 1;
             break;
          end;
      end;
      changingTransformPencil(transformPencilOld.x, transformPencilOld.y);
      for i := left to right do
      begin
          fillRecursion(i, y + 1);
          fillRecursion(i, y - 1);
      end;
    end;
end;
procedure TXCanvas.filling();
var sizePencilOld, transformPencilOld: transform;
begin
    colorTransformPencil := image[transformPencil.y][transformPencil.x];
    sizePencilOld := sizePencil;
    transformPencilOld := transformPencil;
    changingSizePencil(0, 0);
    fillRecursion(transformPencil.x, transformPencil.y);
    changingSizePencil(sizePencilOld.x, sizePencilOld.y);
    changingTransformPencil(transformPencilOld.x, transformPencilOld.y);
end;

procedure TXCanvas.overlayImage(image1: TXCanvas);
var x, x1, y, y1: integer;
begin
    x1 := image1.gettingTransform.x - 1;
    y1 := image1.gettingTransform.y - 1;
    for y := transformPencil.y to transformPencil.y + y1 do
    begin
        for x := transformPencil.x to transformPencil.x + x1 do
        begin
            if (x >= 0) and (x < transformImage.x - 1) and (y >= 0) and (y < transformImage.y - 1) then
            begin
                image[y][x].r := image1.image[y - transformPencil.y][x - transformPencil.x].r;
                image[y][x].b := image1.image[y - transformPencil.y][x - transformPencil.x].b;
                image[y][x].g := image1.image[y - transformPencil.y][x - transformPencil.x].g;
            end;
        end;
    end;
end;

end.
