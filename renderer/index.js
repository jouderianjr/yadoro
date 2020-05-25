import {Elm} from './src/Main.elm';
import '@fortawesome/fontawesome-free/css/all.css';
const  electron = window.require('electron');

const app = Elm.Main.init({
  node: document.getElementById('main'),
  //flags: getFlags(),
});

app.ports.showStopNotification.subscribe(() => {
  const notification = new Notification('Yadoro',{
    body: 'vrau vrau vrau'
  });
});

//app.ports.showStopNotification.subscribe(() => {
  //const notification = new Notification({
    //title: 'Yadoro',
    //subtitle: 'vrau vrau vrau',
  //});
//});
