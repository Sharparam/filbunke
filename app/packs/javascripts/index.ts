import * as Rails from '@rails/ujs';
import * as Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';

import 'channels';

Rails.start();
Turbolinks.start();
ActiveStorage.start();
