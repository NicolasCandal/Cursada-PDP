module Solucion where
import Text.Show.Functions()

type Poder = (Nave -> Nave)
momento :: Poder
momento unaNave = unaNave

data Nave = UnaNave {
    nombre :: String,
    durabilidad :: Int,
    escudos :: Int,
    ataque :: Int,
    poder :: Poder
}  deriving (Show)

mejorarAtaque :: Int -> Poder
mejorarAtaque mejora unaNave = unaNave {ataque = ataque unaNave + mejora} 

mejorarDurabilidad :: Int -> Poder
mejorarDurabilidad mejora unaNave = unaNave {durabilidad = durabilidad unaNave + mejora}

mejorarEscudos :: Int -> Poder 
mejorarEscudos mejora unaNave = unaNave {escudos = escudos unaNave + mejora}

cambiarDurabilidad :: Int -> Poder
cambiarDurabilidad cambio unaNave =unaNave {durabilidad = cambio}

-- 1. Modelar las naves espaciales mencionadas y agregar una nueva nave, con un poder especial sutilmente diferente a alguna de las anteriores, en el que se aproveche las otras implementaciones.

fighter :: Nave
fighter = UnaNave "TIE Fighter" 200 100 50 movimientoTurbo

movimientoTurbo :: Poder
movimientoTurbo = mejorarAtaque 25 

wing :: Nave
wing = UnaNave "Wing" 300 150 100 reparaciondeEmergencia

reparaciondeEmergencia :: Poder
reparaciondeEmergencia = mejorarDurabilidad 50 . mejorarAtaque (-25) 

darthVader :: Nave
darthVader = UnaNave "Darth Vader" 500 300 200 movimientoSuperTurbo

movimientoSuperTurbo :: Poder
movimientoSuperTurbo = mejorarDurabilidad (-45) . movimientoTurbo . movimientoTurbo . movimientoTurbo

falcon :: Nave
falcon = UnaNave "Millennium Falcon" 1000 500 50 reparacionPlus

reparacionPlus :: Poder
reparacionPlus = reparaciondeEmergencia . mejorarEscudos 100

kwid :: Nave
kwid = UnaNave "Renno Kwid" 650 200 50 todoNada

todoNada :: Poder
todoNada = mejorarAtaque 850 . cambiarDurabilidad 25










