#include "loadfile.h"

#include <QFile>
#include <QJsonParseError>
#include <QDebug>


LoadFile::LoadFile(QObject *parent)
{

}

QString LoadFile::load()
{
      QFile loadFile(":/data/save.json");
      if (!loadFile.open(QIODevice::ReadOnly))
      {
          qDebug() << "Could't open json data file!";
      }

      QByteArray allData = loadFile.readAll();
      loadFile.close();
      QJsonParseError json_error;
      QJsonDocument jsonDoc(QJsonDocument::fromJson(allData, &json_error));
      if (json_error.error != QJsonParseError::NoError)
      {
          qDebug() << "Parse json error!";
      }

      return QString(allData);
}

void LoadFile::setJsonData(QJsonObject &json)
{
    QFile saveFile("/root/tempSave.json");    //这里应该保存为二进制  且放在本地程序可以加载的地方

    if (!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
    }
    QJsonDocument saveDoc(json);
    saveFile.write(saveDoc.toJson());
    jsonData = json;
}

