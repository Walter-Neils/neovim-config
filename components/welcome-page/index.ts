import { centerText } from "../../lua/helpers/text/center";
import { actualBufferDimensions } from "../../lua/helpers/window-dimensions";
import { useNUI } from "../../lua/plugins/nui";
import { setTimeout } from "../../lua/shims/mainLoopCallbacks";

export function activateWelcomePage(this: void) {
  // setTimeout(() => {
  //   const NUI = useNUI();
  //   const popup = NUI.Popup({ enter: true, border: 'single' });
  //   const layout = NUI.Layout({
  //     position: '50%',
  //     size: {
  //       width: 80,
  //       height: '60%'
  //     }
  //   }, NUI.Layout.Box([
  //     NUI.Layout.Box(popup, { size: '100%' }),
  //   ], { dir: 'row' }));
  //
  //   for (const key of ["q", "<CR>"]) {
  //     popup.map("n", key, function(this: void) {
  //       layout.unmount();
  //     });
  //   }
  //
  //   popup.on(NUI.event.event.BufLeave, function(this: void) {
  //     popup.unmount();
  //     layout.unmount();
  //   });
  //
  //   layout.mount();
  // }, 1000);
  // setTimeout(() => {
  //   const NUI = useNUI();
  //   const input = NUI.Input({
  //     position: '50%',
  //     size: {
  //       width: 20
  //     },
  //     border: {
  //       style: 'single',
  //       text: {
  //         top: 'Sequence',
  //       }
  //     }
  //   }, {
  //   });
  //   input.mount();
  // }, 1000);
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
