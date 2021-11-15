const MYTRIAL_API = process.env.REACT_APP_API_BASE_URL || "http://localhost:8080";

export const TRIALS_BY_RESEARCHER_END_POINT = `${MYTRIAL_API}/trials`;
export const ADD_TRIAL_END_POINT = `${MYTRIAL_API}/addtrial`;
export const ADD_P_WATCHLIST_END_POINT = `${MYTRIAL_API}/addwatchlist`;
export const RESEARCHER_NAMES_BY_TRAIL = `${MYTRIAL_API}/researcher_names`
export const LOGIN_END_POINT = `${MYTRIAL_API}/login`;
export const REGISTER_END_POINT = `${MYTRIAL_API}/register`;
export const PWATCHLISTS_API_BASE_URL = `${MYTRIAL_API}/watchlists/`;
export const PATIENTS_ALL_BASE_URL = `${MYTRIAL_API}/searchpatients/`;

export default MYTRIAL_API;



