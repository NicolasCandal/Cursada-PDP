module Solucion where
import Text.Show.Functions()
import Data.Char (toUpper)

type Ejercicio = Perro -> Perro
type Tiempo = Int

data Perro = UnPerro {
    raza :: String,
    juguetes :: [String],
    tiempoEnGuarderia :: Int,
    energia :: Int
} deriving Show

data Guarderia = UnaGuarderia {
    nombre :: String,
    rutina :: [(Ejercicio,Tiempo)]
} deriving Show

zara :: Perro
zara = UnPerro "dalmata" ["pelota", "mantita"] 2000 80

-- Funciones auxiliares
-- & --------------------------------------------------------------------------

bajarEnergia :: Int -> Ejercicio
bajarEnergia valor unPerro = unPerro {energia = max 0 (energia unPerro - valor)}

subirEnergia :: Int -> Ejercicio
subirEnergia valor unPerro = unPerro {energia = energia unPerro + valor}

-- ! map de energia
-- mapEnergia :: (Int -> Int) -> Ejercicio
-- mapEnergia modificar unPerro = unPerro {energia = max 0 . modificar . energia }

-- ! uso de flip
--ladrar ladridos unPerro = unPerro {energia = (+ energia unPerro) . flip div 2 $ ladridos}

agregarJuguete :: String -> Ejercicio
agregarJuguete juguete unPerro = unPerro {juguetes = juguete : juguetes unPerro}

cambiarEnergia :: Int -> Ejercicio
cambiarEnergia nuevaEnergia unPerro = unPerro {energia = nuevaEnergia}

razaExtravagante :: Perro -> Bool
razaExtravagante unPerro = raza unPerro == "dalmata" || raza unPerro == "pomeriana"

aplicarDiaSpa :: Perro -> Perro
aplicarDiaSpa  = cambiarEnergia 100 . agregarJuguete "peine de goma" 

-- Punto 1 algunos ejercicios
-- &-------------------------------------------------------------------------

jugar :: Ejercicio
jugar = bajarEnergia 10 

ladrar :: Int -> Ejercicio
ladrar cantidad = subirEnergia (div cantidad 2) 

ladrar' :: Int -> Ejercicio
ladrar' ladridos unPerro = unPerro {energia = (+ energia unPerro) . flip div 2 $ ladridos}

regalar :: String -> Ejercicio
regalar  = agregarJuguete

diaDeSpa :: Ejercicio
diaDeSpa unPerro
  | tiempoEnGuarderia unPerro > 50 = aplicarDiaSpa unPerro
  | razaExtravagante unPerro = aplicarDiaSpa unPerro
  | otherwise = unPerro

diaDeCampo :: Ejercicio
diaDeCampo unPerro = unPerro {juguetes =  tail (juguetes unPerro)}

-- punto 2 ejrecicios con las guarderias
-- &-----------------------------------------------------------------------------------

pDePerritos :: Guarderia
pDePerritos = UnaGuarderia "GuarderiaPdePerritos" [(jugar,30),(ladrar 18,20),(regalar "pelota",0),(diaDeSpa,120),(diaDeCampo,720)]

tiempoDeRutina :: Guarderia -> Int
tiempoDeRutina unaGuarderia =  (sum.map snd) (rutina unaGuarderia)

obtenerEjercicios :: Guarderia -> [Ejercicio]
obtenerEjercicios unaGuarderia = map fst (rutina unaGuarderia) 

hacerTodosLosEjercicios :: [Ejercicio] -> Perro -> Perro
hacerTodosLosEjercicios [] unPerro = unPerro 
hacerTodosLosEjercicios ejercicios unPerro = hacerTodosLosEjercicios (tail ejercicios) $ head ejercicios unPerro

hacerTodosLosEjercicios' :: [Ejercicio] -> Perro -> Perro
hacerTodosLosEjercicios' ejercicios unPerro = foldr (\ejercicio perro -> ejercicio perro) unPerro ejercicios

puedeEstarEnLaGuarderia :: Guarderia -> Perro -> Bool
puedeEstarEnLaGuarderia unaGaurderia unPerro = tiempoDeRutina unaGaurderia < tiempoEnGuarderia unPerro

perroResponsable :: Perro -> Bool
perroResponsable unPerro = (length.juguetes) unPerro > 3

--hacerRutina :: Guarderia -> Ejercicio
--hacerRutina unaGuarderia unPerro 
--  | puedeEstarEnLaGuarderia unaGuarderia unPerro  = 

