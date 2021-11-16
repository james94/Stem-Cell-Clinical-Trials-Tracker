import "./App.css";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import LoginPage from "./components/LoginPage";
import RegisterPage from "./components/RegisterPage";
import LandingPage from "./components/LandingPage";
import ResearcherHomePage from "./components/ResearcherHomePage";
import TrialsPage from "./components/TrialsPage";
import TrialInfoPage from "./components/TrialInfoPage";
import CreateTrialPage from "./components/CreateTrialPage";
import EditPatient from "./components/EditPatient";
import DiscussionForumPage from "./components/DiscussionForumPage";
import DiscussionForumInfoPage from "./components/DiscussionForumInfoPage";
import PatientHomePage from "./components/PatientHomePage";
import PatientPage from "./components/PatientPage";
import PatientInfoPage from "./components/PatientInfoPage";
import PatientWatchlistsPage from "./components/PatientWatchlistsPage";
import SearchViewAllPatients from './components/SearchViewAllPatients';
import ResearcherPage from "./components/ResearcherPage";
import ResearcherInfoPage from "./components/ResearcherInfoPage";
import Top from "./components/Top";
import UpdateDonorPage from "./components/UpdateDonorPage";

function App() {
  return (
    <Router>
      <div>
        <Switch>
          <Route path="/login">
            <Top />
            <LoginPage />
          </Route>
          <Route path="/register">
            <Top />
            <RegisterPage />
          </Route>
          <Route path="/rhome">
            <Top />
            <ResearcherHomePage />
          </Route>
          <Route path="/trials/:id">
            <Top />
            <TrialInfoPage />
          </Route>
          <Route path="/trials">
            <Top />
            <TrialsPage />
          </Route>
          <Route path="/addtrial">
            <Top />
            <CreateTrialPage />
          </Route>

          <Route path="/editpatient/:id" component={EditPatient}>
            {/* <EditPatient /> */}
          </Route>

          <Route path="/discussion/:id">
            <Top />
            <DiscussionForumInfoPage />
          </Route>
          <Route path="/discussion">
            <Top />
            <DiscussionForumPage />
          </Route>
          <Route path="/phome">
            <Top />
            <PatientHomePage />
          </Route>
          <Route path="/patient/:id">
            <Top />
            <PatientInfoPage />
          </Route>
          <Route path="/update_donor/:id">
            <Top />
            <UpdateDonorPage />
          </Route>
          <Route path="/add_donor/:id">
            <Top />
            {/*< Add_Donor_Page/>*/}
          </Route>
          <Route path="/patient">
            <Top />
            <PatientPage />
          </Route>
          <Route path="/pwatchlists/:id">
            <Top />
            <PatientWatchlistsPage />
          </Route>
          <Route path="/researcher/:id">
            <Top />
            <ResearcherInfoPage />
          </Route>
          <Route path="/researcher">
            <Top />
            <ResearcherPage />
          </Route>
          <Route path="/searchpatients">
            <Top />
            <SearchViewAllPatients />
          </Route>
          <Route path="/">
            <Top />
            <LandingPage />
          </Route>
        </Switch>
      </div>
    </Router>
  );
}

export default App;
