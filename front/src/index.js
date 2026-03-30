import React from 'react';
import { createRoot } from 'react-dom/client';

// On cible la div "root" du fichier index.html
const rootElement = document.getElementById('root');
const root = createRoot(rootElement);

// On affiche un simple message pour tester
root.render(
  <div>
    <h1>Mission accomplie !</h1>
    <p>Le frontend React est déployé sur Render.</p>
  </div>
);
