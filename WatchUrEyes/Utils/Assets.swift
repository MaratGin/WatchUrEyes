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



