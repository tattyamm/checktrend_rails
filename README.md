# checktrend rails

Checktrend([iOS](https://itunes.apple.com/jp/app/checktrend-chekkutorendo/id397153166?mt=8), [Android](https://play.google.com/store/apps/details?id=jp.tattyamm.android.checktrend)) backend server by Ruby on Rails on Heroku.

## Requirement
* Create heroku application.
* Add [Redis To Go](https://elements.heroku.com/addons/redistogo) add-on.
* Make ```config/application.yml``` , and write Twitter consumer key, consumer secret.

```
consumerKey: "*****"
consumerSecret: "*****"
```

* Set Heroku environment variables by figaro

```
figaro heroku:set -e production
```

* add Redis To Go url to ```config/application.yml``` .

```
consumerKey: "*****"
consumerSecret: "*****"
REDISTOGO_URL: "redis://localhost:6379/"
```


## Versions
* ruby 2.3.0p0 (2015-12-25 revision 53290)
* Rails 4.2.5
