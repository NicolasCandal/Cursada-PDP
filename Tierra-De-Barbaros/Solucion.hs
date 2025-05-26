module Solucion where
import Text.Show.Functions()
import Data.Char (toUpper)

type Objeto = (Barbaro -> Barbaro)

data Barbaro = UnBarbaro{
  nombre :: String,
  fuerza :: Int,
  habilidades :: [String],
  objetos :: [Objeto]
} deriving Show

dave :: Barbaro
dave = UnBarbaro "Dave" 100 ["tejer","escribirPoesia","Escribir Poesía Atroz"] [espada 10,ardilla]

-- funciones accsiliares
-- &---------------------------------------------------------------------------------------------------------

modificarFuerza :: Int -> Barbaro -> Barbaro
modificarFuerza valor unBarbaro = unBarbaro {fuerza = valor + fuerza unBarbaro}

agregarHabilidad :: String -> Barbaro -> Barbaro
agregarHabilidad nombre unBarbaro = unBarbaro {habilidades = nombre : habilidades unBarbaro}

borrarObjetos :: Barbaro -> Barbaro
borrarObjetos unBarbaro = unBarbaro {objetos = []}

obtenerNombre :: Barbaro -> String
obtenerNombre  = nombre 

-- objetos
-- &---------------------------------------------------------------------------------------------------------

espada :: Int -> Objeto
espada  = modificarFuerza 

amuletoMistico :: String -> Objeto
amuletoMistico = agregarHabilidad

varitaDefectuosa :: Objeto 
varitaDefectuosa  = borrarObjetos . agregarHabilidad "hacerMagia" 

ardilla :: Objeto
ardilla unBarbaro = unBarbaro

cuerda :: Objeto -> Objeto -> Objeto
cuerda objeto1 objeto2  = objeto1 . objeto2 

-- punto 2 megafono
-- &---------------------------------------------------------------------------------------------------------

concatenarHabilidades :: Barbaro -> String
concatenarHabilidades unBarbaro  = concat $ habilidades unBarbaro

megafono :: Objeto
megafono unBarbaro = unBarbaro {habilidades = [map toUpper $ concatenarHabilidades unBarbaro]} 

megafonoBarbarico :: Objeto
megafonoBarbarico  = cuerda ardilla megafono 

-- punto 3 aventuras
-- &---------------------------------------------------------------------------------------------------------

buscarFrase :: String -> String -> Bool
buscarFrase fraseBuscada frase  = frase == fraseBuscada

invasionDeSuciosDuendes :: Barbaro -> Bool
invasionDeSuciosDuendes unBarbaro = any (buscarFrase "Escribir Poesía Atroz") $ habilidades unBarbaro

noTienePulgares :: Barbaro -> Bool
noTienePulgares unBarbaro = obtenerNombre unBarbaro == "Faffy" || obtenerNombre unBarbaro == "Astro"

cremalleraDelTiempo :: Barbaro -> Bool
cremalleraDelTiempo = noTienePulgares 

saqueo :: Barbaro -> Bool
saqueo unBarbaro = any (buscarFrase "robar")  (habilidades unBarbaro) && fuerza unBarbaro > 80

poderGrito :: Barbaro -> Int
poderGrito = length.concatenarHabilidades

poderGritoDeGuerra :: Barbaro -> Bool
poderGritoDeGuerra unBarbaro = poderGrito unBarbaro >  ((* 4). length ) (objetos unBarbaro) 

ritualDeFechorias :: Barbaro -> Bool
ritualDeFechorias unBarbaro = saqueo unBarbaro || poderGritoDeGuerra unBarbaro



