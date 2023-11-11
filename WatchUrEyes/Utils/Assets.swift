//
//  ImageAssets.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 10.11.2023.
//

import Foundation
import UIKit

public enum Asset {
    internal static let golovinTable = UIImage(named: "Golovin")
    internal static let sivcevTable = UIImage(named: "Sivcev")
    internal static let amslerTable = UIImage(named: "Amsler")
    internal static let amslerGood = UIImage(named: "amslerGood")
    internal static let amslerBad = UIImage(named: "amslerBad")
}

public enum TextAsset {
    internal static let sivcevDescription = "    Таблица Сивцева представляет собой таблицу из 12 рядов, состоящий из букв русского алфавита, вам необходимо называть ту букву, которая будет указана на экране!\n  Выполнить проверку можно в 2 режимах - классический и экспресс. В классическом режиме вам необходимо поставить смартфон на уровне ваших глаз и отойти на расстояние 5 метров, Затем произнести  «Запуск», после чего проверка начнется. \n  Экспресс режим предназначен, если у вас не имеется возможности встать на дистанцию 5 метров. Вам необходимо поставить смартфон на уровне ваших глаз и отойти на расстояние не менее 1,5 метров, произнести  «Запуск» и проверка начнется. Пожалуйста, не меняйте свое местоположение во время проверки. \n  Экспресс режим более неточен, поэтому не рекомендуется доверять полученным результатам!"
    internal static let golovinDescription = "    Таблица Головина представляет собой таблицу из 12 рядов, состоящий из комбинации четырех разных колец с разрывом в определённом месте, вам необходимо сказать, в какой стороне находится разрыв.\n  Выполнить проверку можно в 2 режимах - классический и экспресс. В классическом режиме вам необходимо поставить смартфон на уровне ваших глаз и отойти на расстояние 5 метров, Затем произнести  «Запуск», после чего проверка начнется. \n  Экспресс режим предназначен, если у вас не имеется возможности встать на дистанцию 5 метров. Вам необходимо поставить смартфон на уровне ваших глаз и отойти на расстояние не менее 1,5 метров, произнести  «Запуск» и проверка начнется. Пожалуйста, не меняйте свое местоположение во время проверки. \n  Экспресс режим более неточен, поэтому не рекомендуется доверять полученным результатам!"
    internal static let amslerDescription = "    Таблица (решетка) Амслера представляет собой решетку, поделенную на маленькие квадратики. В центре сетки расположена черная точка. Чтобы провести тестирование, необходимо: \n1) Наденьте очки или контактные линзы (если вы их обычно носите). \n2)  Расположите сетку перед собой на расстоянии 20-30 см.\n3) Прикройте 1 глаз, сосредоточив взгляд на центральной точке, оцените остальную часть сетки. \n4) Повторите тест для другого глаза. \nВ норме при выполнении теста Амслера видимое изображение должно быть одинаково на обоих глазах, линии должны быть ровные, без искажений. При обнаружении изменений - обратитесь к врачу-офтальмологу, т. к. это может свидетельствовать о патологических процессах в центральных отделах сетчатки (макулодистрофии)."
    
    internal static let bestVision = "Острота 1.0 Соответствует нормальному зрению без каких-либо отклонений."
    internal static let highVision = "Данная острота считается нормой, хотя является не идеальным показателям. Советуем посетить офтальмолога для подтверждения результата."
    internal static let mediumVision = "Данная острота считается близорукостью.  При такой остроте зрения офтальмолог выписывает очки пациенту. Если у вас нет очков, настоятельно рекомендуем посетить офтмальмолога!"
    internal static let badVision = "Данная острота зрения соответствует сильной близорукостью. Если вы не посещали офтальмолога, то вам срочно стоит пройти обследование! Данные показатели относятся к серьезным отклонениям, которые могут привести к серьезным заболеваниям!"
    
    
    internal static let row1 = [
        ("И", UIImage(named: "e")!),
        ("Б", UIImage(named: "b")!)
    ]
    internal static let row2 = [
        ("М", UIImage(named: "m")!),
        ("Н", UIImage(named: "n")!),
        ("К", UIImage(named: "k")!)
    ]
    internal static let row3 = [
        ("Р", UIImage(named: "r")!),
        ("М", UIImage(named: "m")!),
        ("Б", UIImage(named: "b")!),
        ("И", UIImage(named: "e")!)
    ]
    internal static let row4 = [
        ("Б", UIImage(named: "b")!),
        ("Р", UIImage(named: "r")!),
        ("Н", UIImage(named: "n")!),
        ("К", UIImage(named: "k")!),
        ("М", UIImage(named: "m")!)
    ]
    internal static let row5 = [
        ("И", UIImage(named: "e")!),
        ("Н", UIImage(named: "n")!),
        ("И", UIImage(named: "e")!),
        ("М", UIImage(named: "m")!),
        ("К", UIImage(named: "k")!)
    ]
    internal static let row6 = [
        ("Н", UIImage(named: "n")!),
        ("И", UIImage(named: "e")!),
        ("Р", UIImage(named: "r")!),
        ("И", UIImage(named: "e")!),
        ("К", UIImage(named: "k")!),
        ("Б", UIImage(named: "b")!)
    ]
    internal static let row7 = [
        ("И", UIImage(named: "e")!),
        ("И", UIImage(named: "e")!),
        ("Н", UIImage(named: "n")!),
        ("Б", UIImage(named: "b")!),
        ("Б", UIImage(named: "b")!),
        ("К", UIImage(named: "k")!),
        ("Р", UIImage(named: "r")!)
         ]
    internal static let row8 = [
        ("К", UIImage(named: "k")!),
        ("Н", UIImage(named: "n")!),
        ("И", UIImage(named: "e")!),
        ("М", UIImage(named: "m")!),
        ("Р", UIImage(named: "r")!),
        ("Б", UIImage(named: "b")!),
        ("И", UIImage(named: "e")!)
    ]
    internal static let row9 = [
        ("Б", UIImage(named: "b")!),
        ("К", UIImage(named: "k")!),
        ("И", UIImage(named: "e")!),
        ("М", UIImage(named: "m")!),
        ("И", UIImage(named: "e")!),
        ("Р", UIImage(named: "r")!),
        ("Н", UIImage(named: "n")!)
    ]
    internal static let row10 = [
        ("Н", UIImage(named: "n")!),
        ("К", UIImage(named: "k")!),
        ("И", UIImage(named: "e")!),
        ("Б", UIImage(named: "b")!),
        ("М", UIImage(named: "m")!),
        ("И", UIImage(named: "e")!),
        ("Р", UIImage(named: "r")!),
        ("Б", UIImage(named: "b")!)
    ]
    internal static let row11 = [
        ("И", UIImage(named: "e")!),
        ("Б", UIImage(named: "b")!),
        ("Н", UIImage(named: "n")!),
        ("К", UIImage(named: "k")!),
        ("М", UIImage(named: "m")!),
        ("И", UIImage(named: "e")!),
        ("Р", UIImage(named: "r")!),
        ("Б", UIImage(named: "b")!)
    ]
    internal static let row12 = [
        ("И", UIImage(named: "e")!),
        ("М", UIImage(named: "m")!),
        ("И", UIImage(named: "e")!),
        ("Ы", UIImage(named: "ie")!),
        ("Н", UIImage(named: "n")!),
        ("Б", UIImage(named: "b")!),
        ("М", UIImage(named: "m")!),
        ("К", UIImage(named: "k")!)
    ]
    internal static let golovinRow1 = [
        ("влево", UIImage(named: "left")!),
        ("вправо", UIImage(named: "right")!),
    ]
    
    internal static let golovinRow2 = [
        ("вправо", UIImage(named: "left")!),
        ("вниз", UIImage(named: "down")!),
        ("влево", UIImage(named: "left")!)
    ]
    
    internal static let golovinRow3 = [
        ("вниз", UIImage(named: "down")!),
        ("влево", UIImage(named: "left")!),
        ("вверх", UIImage(named: "up")!),
        ("вправо", UIImage(named: "right")!)
    ]
    internal static let golovinRow4 = [
        ("влево", UIImage(named: "left")!),
        ("вверх", UIImage(named: "up")!),
        ("вниз", UIImage(named: "down")!),
        ("вверх", UIImage(named: "up")!)
    ]
    internal static let golovinRow5 = [
        ("вправо", UIImage(named: "right")!),
        ("влево", UIImage(named: "left")!),
        ("вниз", UIImage(named: "down")!),
        ("вверх", UIImage(named: "up")!),
        ("влево", UIImage(named: "left")!)
    ]
    internal static let golovinRow6 = [
        ("вниз", UIImage(named: "down")!),
        ("вправо", UIImage(named: "right")!),
        ("вверх", UIImage(named: "up")!),
        ("влево", UIImage(named: "left")!),
        ("вправо", UIImage(named: "right")!),
        ("вниз", UIImage(named: "down")!)
    ]
    internal static let golovinRow7 = [
        ("влево", UIImage(named: "left")!),
        ("вниз", UIImage(named: "down")!),
        ("влево", UIImage(named: "left")!),
        ("вправо", UIImage(named: "right")!),
        ("вниз", UIImage(named: "down")!),
        ("влево", UIImage(named: "left")!)
    ]
    internal static let golovinRow8 = [
        ("вправо", UIImage(named: "right")!),
        ("влево", UIImage(named: "left")!),
        ("вверх", UIImage(named: "up")!),
        ("вниз", UIImage(named: "down")!),
        ("вправо", UIImage(named: "right")!),
        ("вверх", UIImage(named: "up")!),
        ("вправо", UIImage(named: "right")!)
    ]
    internal static let golovinRow9 = [
        ("вверх", UIImage(named: "up")!),
        ("вниз", UIImage(named: "down")!),
        ("влево", UIImage(named: "left")!),
        ("вправо", UIImage(named: "right")!),
        ("вверх", UIImage(named: "up")!),
        ("влево", UIImage(named: "left")!),
        ("вниз", UIImage(named: "down")!),
    ]
    internal static let golovinRow10 = [
        ("вправо", UIImage(named: "right")!),
        ("влево", UIImage(named: "left")!),
        ("вверх", UIImage(named: "up")!),
        ("влево", UIImage(named: "left")!),
        ("вниз", UIImage(named: "down")!),
        ("вправо", UIImage(named: "right")!),
        ("вверх", UIImage(named: "up")!),
        ("влево", UIImage(named: "left")!)
    ]
    internal static let golovinRow11 = [
        ("влево", UIImage(named: "left")!),
        ("вверх", UIImage(named: "up")!),
        ("вниз", UIImage(named: "down")!),
        ("вправо", UIImage(named: "right")!),
        ("вниз", UIImage(named: "down")!),
        ("вверх", UIImage(named: "up")!),
        ("влево", UIImage(named: "left")!),
        ("вниз", UIImage(named: "down")!),
    ]
    internal static let golovinRow12 = [
        ("вверх", UIImage(named: "up")!),
        ("влево", UIImage(named: "left")!),
        ("вверх", UIImage(named: "up")!),
        ("вниз", UIImage(named: "down")!),
        ("вправо", UIImage(named: "right")!),
        ("влево", UIImage(named: "left")!),
        ("вниз", UIImage(named: "down")!),
        ("вправо", UIImage(named: "right")!),
    ]
}

public enum SizeAsset {
    internal static let row1Size = CGSize(width: 329.0, height: 300)
    internal static let row2Size = CGSize(width: 164.0, height: 164)
    internal static let row3Size = CGSize(width: 108.0, height: 108.0)
    internal static let row4Size = CGSize(width: 80, height: 80)
    internal static let row5Size = CGSize(width: 57, height: 57)
    internal static let row6size = CGSize(width: 51.7, height: 51.7)
    internal static let row7Size = CGSize(width: 47, height: 47)
    internal static let row8Size = CGSize(width: 42.3, height: 42.3)
    internal static let row9Size = CGSize(width: 38.0, height: 38.0)
    internal static let row10Size = CGSize(width: 33.0, height: 33)
    internal static let row11Size = CGSize(width: 24.0, height: 24)
    internal static let row12Size = CGSize(width: 19.0, height: 19)
}

public enum NumberAsset {
    internal static let row1D = 50.0
    internal static let row2D = 25.0
    internal static let row3D = 16.67
    internal static let row4D = 12.5
    internal static let row5D = 10.0
    internal static let row6D = 8.33
    internal static let row7D = 7.14
    internal static let row8D = 6.25
    internal static let row9D = 5.55
    internal static let row10D = 5.0
    internal static let row11D = 3.33
    internal static let row12D = 2.5
}
