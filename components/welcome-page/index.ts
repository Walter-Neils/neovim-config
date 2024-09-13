import { centerText } from "../../lua/helpers/text/center";
import { actualBufferDimensions } from "../../lua/helpers/window-dimensions";
import { useNUI } from "../../lua/plugins/nui";
import { setTimeout } from "../../lua/shims/mainLoopCallbacks";

export function activateWelcomePage(this: void) {
  setTimeout(() => {
    const NUI = useNUI();
    const menu = NUI.Menu({
      position: '50%',
      size: {
        width: 25,
        height: 5
      },
      border: {
        style: 'single',
        text: {
          top: 'Select an item'
        }
      }
    }, {
      lines: ["Update", "Test2", "Test3"].map(x => NUI.Menu.item(x, { x: 3 })),
      on_submit: item => {
        console.log(item.text);
      }
    });
    // menu.mount();
  }, 2500);
}
