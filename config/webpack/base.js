import { webpackConfig, merge } from '@rails/webpacker';
import ForkTSCheckerWebpackPlugin from 'fork-ts-checker-webpack-plugin';

export default merge(webpackConfig, {
  plugins: [new ForkTSCheckerWebpackPlugin()]
});
