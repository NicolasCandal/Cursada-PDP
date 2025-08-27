module Solucion where
import Text.Show.Functions()

data Pokemon = UnPokemon {
    nombre :: String,
    tipo :: String
} deriving (Show)

charmander :: Pokemon
charmander = UnPokemon "Charmander" "Fuego" 

squartle :: Pokemon
squartle = UnPokemon "Squartle" "Agua" 

bulbasaur :: Pokemon
bulbasaur = UnPokemon "Bulbasaur" "Planta" 

oddish :: Pokemon
oddish = UnPokemon "Oddish" "Planta" 

gyarados :: Pokemon
gyarados = UnPokemon "Gyarados" "Agua"

carpinchos :: Pokemon
carpinchos = UnPokemon "Carpinchos" "Agua"

flareon :: Pokemon
flareon = UnPokemon "Flareon" "Fuego"

leGanaAlAgua :: String -> Pokemon -> Bool
leGanaAlAgua tipos atacado = tipos == "Planta" && tipo atacado == "Agua"

leGanaAlPlanta :: String -> Pokemon -> Bool
leGanaAlPlanta tipos atacado = tipos == "Fuego" && tipo atacado == "Planta"

leGanaAlFuego :: String -> Pokemon -> Bool
leGanaAlFuego tipos atacado = tipos == "Agua" && tipo atacado == "Fuego"

tipoDominante :: String -> Pokemon -> Bool
tipoDominante tipos atacado = leGanaAlAgua tipos atacado || leGanaAlPlanta tipos atacado || leGanaAlFuego tipos atacado

leGanaA :: Pokemon -> [Pokemon] -> [Bool]
leGanaA pokemonAtacante  = map (tipoDominante $ tipo pokemonAtacante) 

pasarANumeros :: Bool -> Int
pasarANumeros boleano
  | boleano = 1
  | otherwise = 0 

aCuantosGana :: Pokemon -> [Pokemon] -> Int
aCuantosGana pokemonAtacante atacados = sum . map pasarANumeros $ leGanaA pokemonAtacante atacados

cualGanaAMas :: [Pokemon] -> Pokemon -> Pokemon -> Pokemon
cualGanaAMas pokemones atacante1 atacante2 
  |aCuantosGana atacante1 pokemones > aCuantosGana atacante2 pokemones = atacante1
  |otherwise = atacante2 

data Destino = UnGimnasio { nombreGym:: String, siguiente:: Destino }
              | UnaLiga { contrincantes:: [Pokemon] } deriving Show

leGanas :: Pokemon -> Pokemon -> Bool
leGanas pokemon1 pokemon2 = tipo pokemon1 == "Planta" && tipo pokemon2 == "Agua" ||tipo pokemon1 =="Agua" && tipo pokemon2 == "Fuego" ||tipo pokemon1 == "Fuego" && tipo pokemon2 == "Planta"

estaAlHorno :: Pokemon -> Destino -> Bool
estaAlHorno _ (UnGimnasio _ _) = True
estaAlHorno pokemon destino = not (any (leGanas pokemon) (contrincantes destino))
 
gymRoca :: Destino
gymRoca = UnGimnasio "Gimnasio Roca" gymAgua
gymAgua :: Destino
gymAgua = UnGimnasio "Gimnasio Agua" gymElectrico
gymElectrico :: Destino
gymElectrico = UnGimnasio "Gimnasio Electrico" ligaKanto
ligaKanto :: Destino
ligaKanto = UnaLiga [flareon, gyarados, charmander]
gymFuego :: Destino
gymFuego = UnGimnasio "Gimnasio Fuego" gymPlanta
gymPlanta :: Destino
gymPlanta = UnGimnasio "Gimnasio Planta" ligaGali
ligaGali :: Destino
ligaGali = UnaLiga [carpinchos, gyarados]