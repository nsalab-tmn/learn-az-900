## Задачи лабораторной работы
* Создать виртуальную сеть
* Развернуть в созданной сети 2 виртуальные машины и проверить связность между ними

## Создание виртуальной сети

В рамках этой задачи вы создадите виртуальную сеть.

1. Войдите на портал Azure по адресу <a href="https://portal.azure.com" target="_blank"><span style="color: #0066cc;" color="#0066cc">https://portal.azure.com</span></a>

2. В колонке **Все службы** найдите и выберите элемент **Виртуальные сети**, а затем нажмите **+ Добавить, + Создать, + Новый**.

3. На вкладке **Основные** укажите следующие сведения (для остальных параметров оставьте значения по умолчанию):

    | Параметр | Значение |
    | --- | --- |
    | Подписка | **Оставьте предоставленные значения по умолчанию** |
    | Группа ресурсов | **rg-lab04-######**|
    | Имя | **vnet1** |
    | Регион | **(США) Восточная часть США** |


4. Нажмите кнопку **Просмотр и создание**. Убедитесь, что проверка выполняется успешно.

## Создание двух виртуальных машин

В рамках этой задачи вы создадите две виртуальных машины в виртуальной сети.

1. В колонке **Все службы** найдите и выберите элемент **Виртуальные машины**, а затем нажмите **+ Добавить, + Создать, + Новый** и выберите в раскрывающемся списке **Виртуальная машина**.

2. На вкладке **Основные** укажите следующие сведения (для остальных параметров оставьте значения по умолчанию):

   | Параметр | Значение |
   | --- | --- |
   | Подписка | **Использовать предоставленное по умолчанию** |
   | Группа ресурсов |  **rg-lab04-######** |
   | Имя виртуальной машины | **vm1**|
   | Регион | **(США) Восточная часть США** |
   | Образ | **Windows Server 2019 Datacenter - пок1** |
   | Размер | **Standard D2s v3**|
   | Имя пользователя| **azureuser** |
   | Пароль| **Pa$$w0rd1234** |
   | Общедоступные входящие порты| Выберите **Разрешить выбранные порты**.  |
   | Выбранные входящие порты| **RDP (3389)** |


3. Перейдите на вкладку **Сеть**. Убедитесь, что виртуальная машина находится в виртуальной сети **vnet1**. Просмотрите параметры по умолчанию, но не вносите никакие другие изменения.

4. Нажмите **Просмотр и создание**. После выполнения проверки нажмите **Создать**. Время развертывания может различаться, однако обычно оно составляет от трех до шести минут.

5. Следя за развертыванием, перейдите к следующему шагу.

6. Создайте вторую виртуальную машину, повторив шаги **с 2 по 4**, приведенные выше. Убедитесь, что для виртуальной машины используется другое имя, а сама виртуальная машина находится в той же виртуальной сети и использует новый общедоступный IP-адрес:

    | Параметр | Значение |
    | --- | --- |
    | Группа ресурсов | **rg-lab04-######** |
    | Имя виртуальной машины |  **vm2** |
    | Виртуальная сеть | **vnet1** |
    | Общедоступный IP-адрес | **vm2-ip** |

7. Подождите, пока обе виртуальные машины не будут развернуты, а их состояние будет определено как *выполняется*.

## Проверка доступности

В этой задаче вы попытаетесь проверить, что виртуальные машины могут взаимодействовать друг с другом (с помощью проверки связи). Если нет, то вы установите правило, разрешающее подключение ICMP. Обычно подключения ICMP автоматически блокируются.

1. В колонке **Все ресурсы** найдите виртуальную машину **vm1**, откройте ее колонку **Обзор** и убедитесь, что параметр **Состояние** имеет значение **Выполняется**. Возможно, вам потребуется **Обновить** страницу.

2. В колонке **Обзор** выберите **Подключить**, а затем выберите **RDP** в раскрывающемся списке.

    **Примечание.** Приведенные ниже указания помогут вам подключиться к виртуальной машине с компьютера под управлением Windows.

3. В колонке **Подключить с RDP** оставьте параметры по умолчанию для подключения по IP-адресу через порт 3389 и нажмите элемент **Скачать RDP-файл**.

4. Откройте загруженный RDP-файл (находится в нижней левой области вашей ВМ) и нажмите **Подключить** после вывода соответствующего приглашения.

5. В окне **Безопасность Windows** введите имя пользователя **azureuser** и пароль **Pa$$w0rd1234**, а затем нажмите кнопку **ОК**.

6. Во время входа в систему может появиться предупреждение о сертификате. Нажмите кнопку **Да**, чтобы создать подключение и подключиться к развернутой виртуальной машине. Подключение должно пройти успешно. Закройте всплывающие окна Windows Server и панели мониторинга. Вы должны увидеть синий фон Windows. Сейчас вы находитесь в своей виртуальной машине.

7. Откройте PowerShell на виртуальной машине, нажав кнопку **Пуск**, и в поле поиска введите **PowerShell**, нажмите правой кнопкой мыши элемент **Windows PowerShell**, чтобы выполнить **Запуск от имени администратора**

8. В Powershell попытайтесь проверить связь для vm2, введя:

   ```PowerShell
   ping vm2
   ```

9. Ваше действие должно выполниться успешно. Вы проверили связь с виртуальной машиной VM2 с VM1.


**Поздравляем!** Вы настроили и выполнили развертывание двух виртуальных машин в виртуальной сети, а затем смогли их подключить.
