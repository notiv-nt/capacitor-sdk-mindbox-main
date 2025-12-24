import { registerPlugin } from '@capacitor/core';
const CapMindbox = registerPlugin('CapMindbox', {
    web: () => import('./web').then(m => new m.CapMindboxWeb()),
});
export * from './definitions';
export { CapMindbox };
//# sourceMappingURL=index.js.map