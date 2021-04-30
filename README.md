# app-c-dash
#### Release Notes
*2.1.2
- Main view Change:
  - add multi-tap on main screen for each view
  - added Testing and Release Views
- web banner will show app name (app-c-dash)

**app-c-dash** is a single page Flutter web app to monitor and pro-activly manage the build process using the [AppCenter platform](https://appcenter.ms/)

### Run using dhttpd
one of the simplest ways to run a flutter web app is to use the [dhttpd package](https://pub.dev/packages/dhttpd)

### Run using docker
from the project root folder run:
````bash
#build your own Image
$tag="unsoop/app-c-dash"
docker build -t $tag .

#run ready Image from DockerHub
docker run --rm unsoop/app-c-Dash 

OR

docker run --rm -p <AnyLigalPortYouLike>:4040 unsoop/app-c-Dash 
````
### Run using Docker-Compose: `docker-compose.yaml`
````yaml
version: "3.7"
services:
  app-c-dash:
    image: unsoop/app-c-dash:latest
    container_name: app-c-dash
    restart: always
````
from the same directory as the docker-compose.yaml, run: <br>
`docker-compose up -d`
## Using the **app-c-dash**
- get your [API key](https://intercom.help/appcenter/en/articles/1841885-how-to-use-app-center-s-api) from youre app Center account (steps 1-7)
- in the browser go to app-c-dash and enter youre API key on the top left.
- to access appCenter for each of youre app, simply press the header of the app (app name) and you will be directed to the build page of that specific app.

![app-c-dash view](https://github.com/AdamRussak/app-c-dash/blob/raw/main/images/v2_main_screen.png)

#### the UI layout:
 - each app give you:.
    - app OS (Android, iOS, UWP).
    - app Platform (Java, xamarin, Swift etc..).
    - app last build branch.
    - app last build Date.
    - app last build ID.
    - app last build Status (sucess, Fail, not configured, Running).
    - app last build result (sucess, Fail, not configured, Running).
- on the top left you will have the last overall app build that was run with the same info as the list.
- on the top right you will have the overall number of apps that where found using your API key.

#### API calls Layout
![app-c-dash API Calls](https://github.com/AdamRussak/app-c-dash/raw/main/images/flutter%20AppCenter%20build%20status%20API.png)
