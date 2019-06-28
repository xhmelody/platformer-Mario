#include <QApplication>
#include <FelgoApplication>

#include <QFile>
#include <QDebug>
#include <QString>
#include <QQmlApplicationEngine>
#include <QJsonParseError>

#include "loadfile.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{



  QApplication app(argc, argv);

  FelgoApplication felgo;

  // QQmlApplicationEngine is the preferred way to start qml projects since Qt 5.2
  // if you have older projects using Qt App wizards from previous QtCreator versions than 3.1, please change them to QQmlApplicationEngine
  QQmlApplicationEngine engine;
  felgo.initialize(&engine);

  LoadFile jsondata;
  engine.rootContext()->setContextProperty("jsondata", &jsondata);

  // use this during development
  // for PUBLISHING, use the entry point below
  felgo.setMainQmlFileName(QStringLiteral("qml/PlatformerMain.qml"));

  // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
  // this is the preferred deployment option for publishing games to the app stores, because then your qml files and js files are protected
  // to avoid deployment of your qml files and images, also comment the DEPLOYMENTFOLDERS command in the .pro file
  // also see the .pro file for more details
  //  felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/PlatformerMain.qml"));

  engine.load(QUrl(felgo.mainQmlFileName()));

  return app.exec();
}

