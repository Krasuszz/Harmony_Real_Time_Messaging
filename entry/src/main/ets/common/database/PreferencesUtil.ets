import dataPreferences from '@ohos.data.preferences';
import Logger from '../utils/Logger';

const TAG = '[PreferencesUtil]';
const PREFERENCES_NAME = 'Login_database'; // 首选项名字
const KEY_ACCOUNT = 'account';  // 首选项Key字段
const KEY_PASSWORD = 'password';  // 首选项Key字段

export class PreferencesUtil
{
  create_login_preferences(context)
  {
    globalThis.get_login_preferences = (() => {
      let preferences: Promise<dataPreferences.Preferences> = dataPreferences.getPreferences(context, PREFERENCES_NAME);
      return preferences;
    });
  }
/*
  saveDefaultFontSize(fontSize: number)
  {
    globalThis.getFontPreferences().then((preferences) => {
      preferences.has(KEY_APP_FONT_SIZE).then(async (isExist) => {
        Logger.info(TAG, 'preferences has changeFontSize is ' + isExist);
        if (!isExist) {
          await preferences.put(KEY_APP_FONT_SIZE, fontSize);
          preferences.flush();
        }
      }).catch((err) => {
        Logger.error(TAG, 'Has the value failed with err: ' + err);
      });
    }).catch((err) => {
      Logger.error(TAG, 'Get the preferences failed, err: ' + err);
    });
  }
*/
  save_user_login(account: string, password: string)
  {
    globalThis.get_login_preferences().then(async (preferences) => {
      await preferences.put(account, password);
      preferences.flush();
    }).catch((err) => {
      Logger.error(TAG, 'put the preferences failed, err: ' + err);
    });
  }

  async get_user_login(account: string)
  {
    let password: string = '';
    const preferences = await globalThis.get_login_preferences();
    password = await preferences.get(account, password);
    return password;
  }

  async delete_user_login(account: string)
  {
    const preferences: dataPreferences.Preferences = await globalThis.get_login_preferences();
    let deleteValue = preferences.delete(account);
    deleteValue.then(() => {
      Logger.info(TAG, 'Succeeded in deleting the key appFontSize.');
    }).catch((err) => {
      Logger.error(TAG, 'Failed to delete the key appFontSize. Cause: ' + err);
    });
  }
}

export default new PreferencesUtil();
