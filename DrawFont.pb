; DrawFont
; Flaith - 2007 - http://flaith.sotfall.fr
; Partie de la fonte rippée à partir de la 
; Delta Demo 
; (c)1991 FTA/MRZ http://www.freetoolsassociation.com/

InitSprite()                                      ; Gestion de la 2D
sePNGImageDecoder()                              ; Gestion du png

#quote = Chr(34)
#SpriteFont = 100
#width = 640
#height = 480

Global TileWidth.l, TileHeight.l

Procedure.l OpenFont(FontName.s, Width.l, Height.l)
Protected Largeur.l = 0, Hauteur.l = 0, SpriteNum.l = 0

  If LoadSprite(#SpriteFont,FontName)
    Hauteur = SpriteHeight(#SpriteFont)
    Largeur = SpriteWidth(#SpriteFont)

    TileWidth  = Width
    TileHeight = Height

    ; Génération des sprites (1 sprite par caractère)
    UseBuffer(#SpriteFont)
    For y = 0 To Hauteur-TileHeight
      For x = 0 To largeur-TileWidth
        If x % TileWidth = 0 And y % TileHeight = 0
          GrabSprite(SpriteNum, x, y, TileWidth, TileHeight)
          SpriteNum + 1
        EndIf
      Next
    Next
    UseBuffer(-1)                                 ;OBLIGATOIRE
  Else
    MessageRequester("*** ERROR","Cannot load "+#quote+FontName+#quote)
    End
  EndIf
EndProcedure

Procedure _DrawText(PosX.l, PosY.l, Txt.s)
Protected car.l, x.l, y.l

  x = PosX : y = PosY
  
  For i = 1 To Len(Txt)
    a$ = Mid(txt,i,1)
    car = Asc(a$) - 32
    DisplayTransparentSprite(car,X,Y)
    x + TileWidth
 Next i
EndProcedure

Procedure flip()                        ;by polux

FlipBuffers()
If IsScreenActive()=0
    Repeat
      Delay(25)
      FlipBuffers()
    Until IsScreenActive()
 EndIf
EndProcedure

Procedure Rectangle(x,y,largeur,color)
Protected H.b = 2
Protected B.b = 6

  StartDrawing(ScreenOutput())
    ; Haut
    LineXY(x-H,y-H,x+(largeur*TileWidth),y-H,color)
    ; Bas
    LineXY(x-H,#height-B,x+(largeur*TileWidth),#height-B,color)

    ; gauche
    LineXY(x-H,y-H,x-H,#height-B,color)
    ; droite
    LineXY(x+(largeur*TileWidth),y-H,x+(largeur*TileWidth),#height-B,color)
  StopDrawing()
EndProcedure

If OpenWindow(0, 0, 0, #width, #height+70, "DrawFont TEST", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
  If CreateGadgetList(WindowID(0))
    ButtonGadget(0, #width-70, #height+25, 55, 20, "Quitter")
  EndIf
  If OpenWindowedScreen(WindowID(0), 0, 0, #width, #height, 0, 0, 0)

  Else
    MessageRequester("Erreur", "Impossible d'ouvrir un écran dans la fenêtre!", 0)
    End
  EndIf
EndIf

OpenFont("MyFont.png",12,12)

txt$ = "                                                             welcome to my "
txt$ + "underground lair,                     ---> the world is my oyster <---     "
txt$ + "                     ........................ and now the complete font :  "
txt$ + " !"+Chr(34)+"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`"
txt$ + "abcdefghijklmnopqrstuvwxyz{|}~"+Chr(127)+"              bye bye and thanks "
txt$ + "to the PureBasic Community  :)                                             "
i = 1

Repeat
  Repeat
    Event = WindowEvent()
    
    Select Event 
      Case #PB_Event_Gadget
        If EventGadget() = 0
          End
        EndIf

      Case #PB_Event_CloseWindow
        End 
    EndSelect
  Until Event = 0

  ClearScreen(0)
    _DrawText(80,300,             "[Equation] : ((40*12)+5.2)/3")
    _DrawText(80,300+TileHeight,  "           = ((480)+5.2)/3")
    _DrawText(80,300+TileHeight*2,"           = 485.2/3")
    _DrawText(80,300+TileHeight*3,"           = 161.7333")
    tmp$ = Mid(txt$,i,40)
    larg = 40*Tilewidth
    xp = (#width-larg)/2
    yp = #height-TileHeight-5
    Rectangle(xp,yp,40,$55ff55)
    
    tmp$=UCase(tmp$)
    _DrawText(xp,yp,tmp$)
    i + 1 : Delay(100)
    If i > Len(txt$) : i = 1 : EndIf
  flip()      
ForEver
; IDE Options = PureBasic v4.02 (Windows - x86)
; CursorPosition = 162
; FirstLine = 110
; Folding = -
; Executable = DrawFont.exe
; DisableDebugger
