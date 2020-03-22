# checktrend rails

Checktrend([iOS](https://itunes.apple.com/jp/app/checktrend-chekkutorendo/id397153166?mt=8), [Android](https://play.google.com/store/apps/details?id=jp.tattyamm.android.checktrend)) backend server by Ruby on Rails on Heroku.

## Requirement
* Create heroku application.
* Add [Redis To Go](https://elements.heroku.com/addons/redistogo) add-on.
* Make ```config/application.yml``` , and write Twitter, Microsoft setting.

```
# twitter
consumerKey: "*****"
consumerSecret: "*****"
# microsoft
MS_TRANSLATOR_CLIENT_ID: "*****"
MS_TRANSLATOR_CLIENT_SECRET: "*****"
# Amazon Product Advertising API
AMAZON_PAAPI_MARKETPLACE: "***"
AMAZON_PAAPI_ACCESS_KEY: "***"
AMAZON_PAAPI_SECRET_KEY: "***"
AMAZON_PAAPI_PARTNER_TAG: "***"
```

* Set Heroku environment variables by figaro

```
figaro heroku:set -e production
```

* add Redis To Go url to ```config/application.yml``` .

```
REDISTOGO_URL: "redis://localhost:6379/"
```


## Versions
* ruby 2.6.5
* Rails 5.2.4.1

## License
This software is released under the MIT License, see LICENSE.txt.

## Author
[tattyamm](https://twitter.com/tattyamm)
