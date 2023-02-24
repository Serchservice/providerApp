import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

// Get.updateLocale(Locale("es"));
String getLanguageName(BuildContext context) {
  // final languageCode = allLocales.where(
  //  (element) => element.locale.languageCode == Localizations.localeOf(context).languageCode
  //).single;
  final code = Get.locale?.languageCode ?? "en";
  final languageCode = allLocales.where((element) => element.locale.languageCode == code).single;
  // return Locale.fromSubtags(languageCode: languageCode.locale.languageCode).toLanguageTag().toUpperCase();
  return languageCode.languageName;
}

void showSerchLocaleModalBottomSheet(BuildContext context) {
  Get.bottomSheet(
    CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SText.center(
                text: "Select a language".toUpperCase().tr,
                color: SColors.hint,
                weight: FontWeight.bold,
                size: 18
              )
            ),
          )
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.updateLocale(allLocales[index].locale);
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(
                    color: Theme.of(context).backgroundColor, width: 2.0
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: const EdgeInsets.only(right: 10), child: Icon(
                        Icons.language_rounded, color: Theme.of(context).primaryColor, size: 24
                      )),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SText(
                              text: allLocales[index].languageName,
                              size: 18, weight: FontWeight.bold,
                              color: Theme.of(context).primaryColor
                            ),
                            const SizedBox(width: 5),
                            SText(
                              text: "(${allLocales[index].locale.languageCode.toUpperCase()})",
                              size: 14, color: Theme.of(context).primaryColor
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            childCount: allLocales.length
          ),
        )
      ]
    ),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  );
}

// void showLocaleModalBottomSheet(BuildContext context) {
//   Get.bottomSheet(
//     ListView.builder(
//       itemCount: supportedLocales.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(supportedLocales[index].displayName),
//           onTap: () {
//             Get.updateLocale(supportedLocales[index]);
//             Get.back(); // dismiss the modal bottom sheet
//           },
//         );
//       },
//     ),
//   );
// }

// // Define the list of supported locales
// final supportedLocales = [  Locale('en', 'US'),  Locale('es', 'ES'),  Locale('fr', 'FR'),  // add more locales as needed
// ];

class SerchLocales {
  final String languageName;
  final Locale locale;

  SerchLocales(this.languageName, this.locale);
}

List<SerchLocales> allLocales = [
  SerchLocales('Afrikaans', const Locale('af')),
  SerchLocales('Albanian', const Locale('sq')),
  SerchLocales('Amharic', const Locale('am')),
  SerchLocales('Arabic', const Locale('ar')),
  SerchLocales('Armenian', const Locale('hy')),
  SerchLocales('Azerbaijani', const Locale('az')),
  SerchLocales('Basque', const Locale('eu')),
  SerchLocales('Belarusian', const Locale('be')),
  SerchLocales('Bengali', const Locale('bn')),
  SerchLocales('Bosnian', const Locale('bs')),
  SerchLocales('Bulgarian', const Locale('bg')),
  SerchLocales('Catalan', const Locale('ca')),
  SerchLocales('Cebuano', const Locale('ceb')),
  SerchLocales('Chinese (Simplified)', const Locale('zh', 'CN')),
  SerchLocales('Chinese (Traditional)', const Locale('zh', 'TW')),
  SerchLocales('Corsican', const Locale('co')),
  SerchLocales('Croatian', const Locale('hr')),
  SerchLocales('Czech', const Locale('cs')),
  SerchLocales('Danish', const Locale('da')),
  SerchLocales('Dutch', const Locale('nl')),
  SerchLocales('English', const Locale('en')),
  SerchLocales('Esperanto', const Locale('eo')),
  SerchLocales('Estonian', const Locale('et')),
  SerchLocales('Finnish', const Locale('fi')),
  SerchLocales('French', const Locale('fr')),
  SerchLocales('Frisian', const Locale('fy')),
  SerchLocales('Galician', const Locale('gl')),
  SerchLocales('Georgian', const Locale('ka')),
  SerchLocales('German', const Locale('de')),
  SerchLocales('Greek', const Locale('el')),
  SerchLocales('Gujarati', const Locale('gu')),
  SerchLocales('Haitian Creole', const Locale('ht')),
  SerchLocales('Hausa', const Locale('ha')),
  SerchLocales('Hawaiian', const Locale('haw')),
  SerchLocales('Hebrew', const Locale('he')),
  SerchLocales('Hindi', const Locale('hi')),
  SerchLocales('Hmong', const Locale('hmn')),
  SerchLocales('Hungarian', const Locale('hu')),
  SerchLocales('Icelandic', const Locale('is')),
  SerchLocales('Igbo', const Locale('ig')),
  SerchLocales('Indonesian', const Locale('id')),
  SerchLocales('Irish', const Locale('ga')),
  SerchLocales('Italian', const Locale('it')),
  SerchLocales('Japanese', const Locale('ja')),
  SerchLocales('Javanese', const Locale('jv')),
  SerchLocales('Kannada', const Locale('kn')),
  SerchLocales('Kazakh', const Locale('kk')),
  SerchLocales('Khmer', const Locale('km')),
  SerchLocales('Kinyarwanda', const Locale('rw')),
  SerchLocales('Korean', const Locale('ko')),
  SerchLocales('Lao', const Locale('lo')),
  SerchLocales('Latvian', const Locale('lv')),
  SerchLocales('Lithuanian', const Locale('lt')),
  SerchLocales('Luxembourgish', const Locale('lb')),
  SerchLocales('Macedonian', const Locale('mk')),
  SerchLocales('Malagasy', const Locale('mg')),
  SerchLocales('Malay', const Locale('ms')),
  SerchLocales('Malayalam', const Locale('ml')),
  SerchLocales('Maltese', const Locale('mt')),
  SerchLocales('Maori', const Locale('mi')),
  SerchLocales('Marathi', const Locale('mr')),
  SerchLocales('Mongolian', const Locale('mn')),
  SerchLocales('Myanmar (Burmese)', const Locale('my')),
  SerchLocales('Nepali', const Locale('ne')),
  SerchLocales('Norwegian', const Locale('no')),
  SerchLocales('Nyanja (Chichewa)', const Locale('ny')),
  SerchLocales('Odia (Oriya)', const Locale('or')),
  SerchLocales('Pashto', const Locale('ps')),
  SerchLocales('Persian', const Locale('fa')),
  SerchLocales('Polish', const Locale('pl')),
  SerchLocales('Portuguese', const Locale('pt')),
  SerchLocales('Punjabi', const Locale('pa')),
  SerchLocales('Romanian', const Locale('ro')),
  SerchLocales('Russian', const Locale('ru')),
  SerchLocales('Samoan', const Locale('sm')),
  SerchLocales('Scots Gaelic', const Locale('gd')),
  SerchLocales('Serbian', const Locale('sr')),
  SerchLocales('Sesotho', const Locale('st')),
  SerchLocales('Shona', const Locale('sn')),
  SerchLocales('Sindhi', const Locale('sd')),
  SerchLocales('Sinhala (Sinhalese)', const Locale('si')),
  SerchLocales('Slovak', const Locale('sk')),
  SerchLocales('Slovenian', const Locale('sl')),
  SerchLocales('Somali', const Locale('so')),
  SerchLocales('Spanish', const Locale('es')),
  SerchLocales('Sundanese', const Locale('su')),
  SerchLocales('Swahili', const Locale('sw')),
  SerchLocales('Swedish', const Locale('sv')),
  SerchLocales('Tagalog (Filipino)', const Locale('tl')),
  SerchLocales('Tajik', const Locale('tg')),
  SerchLocales('Tamil', const Locale('ta')),
  SerchLocales('Tatar', const Locale('tt')),
  SerchLocales('Telugu', const Locale('te')),
  SerchLocales('Thai', const Locale('th')),
  SerchLocales('Turkish', const Locale('tr')),
  SerchLocales('Turkmen', const Locale('tk')),
  SerchLocales('Ukrainian', const Locale('uk')),
  SerchLocales('Urdu', const Locale('ur')),
  SerchLocales('Uyghur', const Locale('ug')),
  SerchLocales('Uzbek', const Locale('uz')),
  SerchLocales('Vietnamese', const Locale('vi')),
  SerchLocales('Welsh', const Locale('cy')),
  SerchLocales('Xhosa', const Locale('xh')),
  SerchLocales('Yiddish', const Locale('yi')),
  SerchLocales('Zulu', const Locale('zu')),
  SerchLocales('Chinese', const Locale('zh')),
  SerchLocales('Chinese (Hong Kong)', const Locale('zh_HK')),
  SerchLocales('Chinese (Simplified)', const Locale('zh_Hans')),
  SerchLocales('Chinese (Singapore)', const Locale('zh_SG')),
  SerchLocales('Chinese (Taiwan)', const Locale('zh_TW'))
];