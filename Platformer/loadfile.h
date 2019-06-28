#ifndef LOADFILE_H
#define LOADFILE_H
#include <QObject>
#include <QString>
#include <QJsonObject>
class LoadFile : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString load READ load NOTIFY loadChanged)
    Q_PROPERTY(QJsonObject jsonData WRITE setJsonData)
public:
    explicit LoadFile(QObject *parent = nullptr);

    /*Q_INVOKABLE */
    QString load();
    void setJsonData(QJsonObject &json);

signals:
    void loadChanged(QString s);
public slots:

private:
//    QString man2;
    QJsonObject jsonData;
};

#endif // LOADFILE_H


