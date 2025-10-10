program project1;

uses unit1, sysutils;

var
    s, s1: TXCanvas;
    NameFile, NameFile1, NameFile2: string;
begin
    NameFile := 'image.ppm';
    NameFile1 := 'image1.ppm';
    NameFile2 := 'image2.ppm';
    s := TXCanvas.Create;
    s1 := TXCanvas.Create;
    {s1.fileLoad(NameFile1);
    s.changingTransform(1000,1000);

    s.changingColorPencil(0,0,0);
    s.changingTransformPencil(20,20);
    s.rectanglePaint(480,480);
    s.changingColorPencil(0,255,0);
    s.changingTransformPencil(250,250);
    s.changingSizePencil(0,0);
    s.linePaint(250,100);
    s.changingTransformPencil(250,250);
    s.linePaint(100,250);
    s.changingTransformPencil(100,100);
    s.changingColorPencil(0,0,255);
    s.filling();
    s.changingTransformPencil(400,400);
    s.overlayImage(s1);   }

    s.changingTransform(100, 100);
    s.changingTransformPencil(40, 60);

    s.linePaint(0, -20);
    s.linePaint(10, -10);
    s.linePaint(10, 10);
    s.linePaint(-20, 0);
    s.linePaint(20, 20);
    s.linePaint(-20, 0);
    s.linePaint(20, -20);
    s.linePaint(0, 20);

    s.changingTransformPencil(42, 50);
    s.changingColorPencil(255,0,0);
    s.filling();
    s.changingTransformPencil(58, 50);
    s.changingColorPencil(0,255,0);
    s.filling();
    s.changingTransformPencil(50, 55);
    s.changingColorPencil(0,0,255);
    s.filling();
    s.changingTransformPencil(50, 45);
    s.changingColorPencil(0,255,255);
    s.filling();
    s.changingTransformPencil(50, 35);
    s.changingColorPencil(255,255,0);
    s.filling();

    s.fileSave(NameFile);
    s.free;
    s1.free;
end.

