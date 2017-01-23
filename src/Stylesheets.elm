port module Stylesheets exposing (..)

import Css.File exposing (..)

import ModalCss exposing (..)

port files : CssFileStructure -> Cmd msg

fileStructure : CssFileStructure
fileStructure =
  toFileStructure [ ( "styles.css", compile [ ModalCss.css ] ) ]

main : CssCompilerProgram
main =
  compiler files fileStructure
