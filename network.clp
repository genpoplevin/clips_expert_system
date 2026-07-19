;; 1. Стартовое правило (запускается всегда при (reset) и (run))
(defrule start-system
   =>
   (printout t "=== Экспертная система: Диагностика Сети ===" crlf)
   (printout t "Кабель подключен? (yes/no): ")
   (assert (link-answer (read))))

;; 2. Ветка: Кабеля нет
(defrule link-no
   (link-answer no)
   =>
   (printout t "РЕШЕНИЕ: Проверьте сетевой кабель или включите Wi-Fi." crlf))

;; 3. Ветка: Кабель есть -> Спрашиваем про IP
(defrule link-yes
   (link-answer yes)
   =>
   (printout t "Введите, пожалуйста, команду ipconfig в терминале cmd или powershell"crlf)
   (printout t "Какой IP-адрес получен?"crlf)
   (printout t "Если IPv4-адрес начинается на 192.168, введите valid / в ином случае введите apipa: ")
   (assert (ip-answer (read))))

;; 4. Ветка: IP дефектный
(defrule ip-apipa
   (ip-answer apipa)
   =>
   (printout t "РЕШЕНИЕ: Проблема с DHCP. Перезагрузите роутер." crlf))

;; 5. Ветка: IP в норме -> Спрашиваем про сайты
(defrule ip-valid
   (ip-answer valid)
   =>
   (printout t "Сайты открываются? (yes/no): ")
   (assert (site-answer (read))))

;; 6. Ветка: Сайты не открываются
(defrule sites-no
   (site-answer no)
   =>
   (printout t "РЕШЕНИЕ: Проблема с DNS или на стороне провайдера." crlf))

;; 7. Ветка: Все отлично
(defrule sites-yes
   (site-answer yes)
   =>
   (printout t "РЕШЕНИЕ: Сеть работает исправно!" crlf))
