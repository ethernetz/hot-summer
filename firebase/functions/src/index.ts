import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);

export const createUserDocument = functions.auth.user().onCreate((userRecord) => {
	functions.logger.info(`Running createUserDocument! ${userRecord.uid}`);
	const user = {
		uid: userRecord.uid,
		email: userRecord.email,
		displayName: userRecord.displayName,
	};
	return admin.firestore().collection('users').doc(userRecord.uid).set(user);
});
