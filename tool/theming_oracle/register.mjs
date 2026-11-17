// Upstream theming-runtime ships bundler-style ESM: relative imports without
// file extensions (e.g. './builder'). Node's ESM loader requires extensions,
// so this hook retries such imports with '.js' and '/index.js'.
// Loaded with: node --import ./register.mjs oracle.mjs
import { registerHooks } from 'node:module';

registerHooks({
  resolve(specifier, context, nextResolve) {
    try {
      return nextResolve(specifier, context);
    } catch (error) {
      const relative = specifier.startsWith('./') || specifier.startsWith('../');
      const notFound = error?.code === 'ERR_MODULE_NOT_FOUND' || error?.code === 'ERR_UNSUPPORTED_DIR_IMPORT';
      if (!relative || !notFound) throw error;
      for (const suffix of ['.js', '/index.js']) {
        try {
          return nextResolve(specifier + suffix, context);
        } catch {
          // try the next suffix
        }
      }
      throw error;
    }
  },
});
