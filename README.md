# Medicine to do list's functions

## 1. Calendar
    + On the calendar, you can see at once what medicine to take by date.
    + The start and end dates of the quarantine period are recorded and marked on
      the calendar to immediately know until when the quarantine period is maintained.
    
   
## 2. Add Event
    + You can set the year, month, and day to immediately add events to that date.
    + The event is immediately added to the calendar.


## 3. New Medicine
    + You can check the medicines you need to take today at once.
    + You can check whether you took medicine or not.
    + You can set the alarm.
    + You can check each medicine by adding pictures and explanations.
    

## 4. Daily Survey
    + You can use the search function to find the alarm you saved at once.
    + You can write down today's report and transfer at web database.
    + You can use the check function to distinguish between
      what you have to do and what you have done.


# Directory Explanations


## android
    + consist the build file of the andorid application

## assets/images
    + a direcotory that stores the static image files of the application

## ios
    + consist the build file of the ios application

## calendar
    + consist the dart code for android application


## services
    + consist the handler code for the applications

## web
    + consist the build file of web application


# Class Explanations


## To learn the application and to show the main page of it.
    + MyApp
    + MyPage


## To add, delete and update the medicine Log.
    + MedicineRepository
    + MedicineLogRepository


## To go to the main page of New schedule with UI.
    + Homepage
    + BeforeTile
    + AfterTile
    + DeleteDataButton
    + MedicinePhoto
    + TileActionButton


## To come up with bottom sheet with adding alarm and medicine function.
    + BottomSheetBody
    + TimeSettingBottomSheet
    + AddAlarmButton
    + AddAlarmPage
    + AlarmBox
    + AddMedicinePage
    + MedicineIconButton
    + PickImageBottomSheet
    + BasicPageBodyFormet


## To use flutter hive adapter function
    + HiveStorage
    + HiveStorageBox
    + Medicine
    + MedicineAdapter
    + MedicineLog
    + MedicineLogAdapter
    + MedicineAlarm


## To go to the main page of calendar.
    + Claendar
    + Event


## To use the service portal function.
    + SpUtils
    + DateHistoryStorage
    + MessageLookup
    + S


## To localize the app.
    + AppLocalizationDelegate


## To go to the main page of Daily Survey.
    + MySurveylist
    + Survey
    + SurveysPage
    + SurveyHeader
    + CreateSurvey
    + SearchAndFilterSurvey
    + ShowSurveys
    + SurveyItem
    + ActivieSurveyCountState
    + ActivieSurveyCount


## To use filter and search function.
    + FilteredSurveyState
    + FilteredSurveys
    + SurveyFilterState
    + SurveyFilter
    + SurveyListSate
    + SurveyList
    + SurveySearchState
    + SurveySearch


## To limit action frequency. 
    + Debounce

