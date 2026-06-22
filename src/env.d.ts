/// <reference path="../.astro/types.d.ts" />

// Allow importing the setup script as a URL string for the download link.
declare module '*.sh?url' {
  const src: string;
  export default src;
}
