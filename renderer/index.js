import {Elm} from './src/Main.elm';
import '@fortawesome/fontawesome-free/css/all.css';
const electron = window.require('electron');

const app = Elm.Main.init({
  node: document.getElementById('main'),
});

app.ports.showStopNotification.subscribe(msg => {
  const notification = new Notification('Time!', {
    body: msg,
  });
});
