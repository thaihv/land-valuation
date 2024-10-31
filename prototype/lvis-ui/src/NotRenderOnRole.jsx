import PropTypes from 'prop-types'
import UserService from "./state/UserService";
import NotAllowed from "./NotAllowed";

const NotRenderOnRole = ({ roles, showNotAllowed, children }) => (
  UserService.hasRole(roles)) ? showNotAllowed ? <NotAllowed/> : null : children;

NotRenderOnRole.propTypes = {
  roles: PropTypes.arrayOf(PropTypes.string).isRequired,
}

export default NotRenderOnRole
