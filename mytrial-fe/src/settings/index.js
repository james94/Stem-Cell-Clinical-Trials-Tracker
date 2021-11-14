const MYTRIAL_API =
  process.env.REACT_APP_API_BASE_URL || "http://localhost:8080";

export const TRIALS_BY_RESEARCHER_END_POINT = `${MYTRIAL_API}/trials`;
//export const TRIALS_BY_TRIAL_ID_END_POINT = `${MYTRIAL_API}/trial`;
export const TRIALS_BY_PATIENT_END_POINT = ``;
export const ADD_TRIAL_END_POINT = `${MYTRIAL_API}/addtrial`;
export const LOGIN_END_POINT = `${MYTRIAL_API}/login`;
export const PWATCHLISTS_API_BASE_URL = `${MYTRIAL_API}/watchlists/`;
export const PATIENT_INFO = `${MYTRIAL_API}/patient/`;
export const EDIT_PATIENT = `${MYTRIAL_API}/editpatient/`;
