import { LightningElement } from 'lwc';
import smallScreen1 from './smallScreen.html';
import largeScreen1 from './largeScreen.html';
export default class RenderHtml extends LightningElement {
    render() {
        return window.screen.width < 768 ? smallScreen1 : largeScreen1;
      }

}