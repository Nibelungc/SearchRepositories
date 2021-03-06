# SearchRepositories

Тестовое задание для прохождения технического интервью на позцицю iOS разработчика.

## Задание:

> Необходимо сделать приложение, которое ищет на репозитории на сайте github.com и сохраняет их в избранные для просмотра в оффлайн-режиме.
Требования к приложению:
-  Приложение должно состоять из двух экранов: список избранных репозиториев и экран поиска.
-  На экране поиска должно быть поле для ввода поискового запроса и список найденных по нему репозиториев. При нажатии на ячейку репозиторий добавляется в избранные.
-  На экране избранных должен быть список репозиториев, которые были добавлены в избранное во время поиска. Список избранных должен быть доступен без подключения к интернету.
-  Для поиска используется запрос https://developer.github.com/v3/search/#search-repositories
-  Можно использовать любые сторонние библиотеки.
-  Необходима поддержка iOS 8 и выше.

## Решение

В приложении реализованы все требования. Плюс дополнительные возможности:
- Быстрый поиск. Search as you type.
- Постраничная загрузка с индикатором.
- Отобажение состояния экрана поиска (начальный, пустой, ошибка).
- Удаление избранных из экрана поиска.
- Избранные репозитории в поиске отображаются с закрашеной иконкой звезды.
- Удаление свайпом на вкладке избранных. 

## Дополнительная информация
В приложении 3 зависимости:
- [`libextobjc/EXTScope`](https://github.com/jspahrsummers/libextobjc) для ослабления сильных ссылок на self, при передаче в блок.
- [`Typhoon`] (https://github.com/appsquickly/Typhoon) DI-контейнер для сборки модулей.
- [`Mantle`] (https://github.com/Mantle/Mantle) парсинг json + NSCoding for free.

Сетевые запросы реализованы с помощью `NSURLSession`.
